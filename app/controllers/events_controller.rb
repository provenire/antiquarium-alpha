class EventsController < ApplicationController
  
  def index
    redirect_to artifacts_path
  end
  
  def show
    @event = Event.find_by_uuid!(params[:id])
    gon.entity_id = @event.uuid
    if @event.price
      gon.currency = Money::Currency.table.values.sort{|a,b| a[:priority]<=>b[:priority] }.map{|c| { value: c[:iso_code], text: c[:iso_code]}}
      gon.iso_to_symbol = Hash[*Money::Currency.table.values.sort{|a,b| a[:priority]<=>b[:priority] }.map{|c| [c[:iso_code], (c[:symbol] || '')] }.flatten]
      gon.price = {
        iso: @event.price.currency.iso_code.upcase,
        value: @event.price.format(no_cents: true, symbol: false, thousands_separator: false)
      }
    end
  end
  
  def new
    @verb     = Verb.find_by(keyword: params[:type]) || Verb.find_by(keyword: 'transported_to')
    @artifact = Artifact.find_by_uuid!(params[:artifact_id])
    @event    = Event.new
  end
  
  def create
    @verb     = Verb.find_by(keyword: params[:event][:verb]) || Verb.find_by(keyword: 'transported_to')
    @artifact = Artifact.find_by_uuid!(params[:event].delete(:artifact))
    
    @event = Event.new(event_params)
    @event.artifacts << @artifact
    
    if params[:actor_primary_unknown].nil? && !params[:actor_primary].to_s.empty?
      primary_actor = JSON.parse(params[:actor_primary])
      primary_actor = primary_actor["type"].constantize.find_by_uuid!(primary_actor["id"])
      @event.interactions.new(actor: primary_actor, recipient: false)
    elsif !params[:actor_primary_unknown].nil?
      @event.interactions.new(unknown_actor: true)
    end
    
    if params[:actor_secondary_unknown].nil? && !params[:actor_secondary].to_s.empty?
      secondary_actor = JSON.parse(params[:actor_secondary])
      secondary_actor = secondary_actor["type"].constantize.find_by_uuid!(secondary_actor["id"])
      @event.interactions.new(actor: secondary_actor, recipient: true)
    elsif !params[:actor_secondary_unknown].nil?
      @event.interactions.new(unknown_actor: true, recipient: true)
    end
    
    if params[:location_unknown].nil? && !params[:location].to_s.empty?
      @event.build_location(address: params[:location])
    end
    
    
    # Save
    if @event.save
      redirect_to @event
    else
      render "new"
    end
  end
  
  def edit
  end
  
  def update
    @event = Event.find_by_uuid(params[:id])
    
    if params[:name] == 'location'
      location = Location.create(address: params[:value])
      @event.update_attributes(location: location)
      return render nothing: true
    end

    if params[:actor]
      recipient = (params[:actor][:kind] == "secondary")
      if params[:actor][:unknown]
        @event.interactions.create(unknown_actor: true, recipient: recipient)
        return render json: { unknown: true }
      end
      if params[:actor][:info]
        actor = JSON.parse(params[:actor][:info])
        actor = actor["type"].constantize.find_by_uuid!(actor["id"])
        @event.interactions.create(actor: actor, recipient: recipient)
        return render json: actor
      end
    end
    
    if params[:remove_actor]
      recipient = (params[:remove_actor][:kind] == "secondary")
      if params[:remove_actor][:type] == "Unknown"
        @event.interactions.where(unknown_actor: true, recipient: recipient).each{|i| i.create_activity('destroy')}
        @event.interactions.where(unknown_actor: true, recipient: recipient).delete_all
      else
        actor = params[:remove_actor][:type].constantize.find_by_uuid!(params[:remove_actor][:id])
        @event.interactions.where(actor: actor, recipient: recipient).each{|i| i.create_activity('destroy')}
        @event.interactions.where(actor: actor, recipient: recipient).delete_all
      end
      return render json: { deleted: true }
    end

    @event.update_attributes(params[:name] => params[:value])
    render nothing: true
  end
  
  def destroy
  end
  
  
  def history
    @event = Event.find_by_uuid!(params[:id])
    @versions = @event.versions.each{|v| v.whodunnit = User.find(v.whodunnit.to_i); v.changeset.delete(:updated_at) }
    @versions.sort!{|a,b| b.created_at <=> a.created_at }
  end
  
  
  
  def actors
    query = params[:q]
    results = PgSearch.multisearch(query).where(searchable_type: ['Person', 'Place'])
    respond_to do |format|
      format.json {
        render :json => results.map{|a| 
          {
            id:    a.searchable.uuid,
            text:  a.searchable.name,
            type:  a.searchable.class.to_s
          }
        }
      }
    end
  end
  
  
  
  private
  
  def event_params
    params.require(:event).permit(:verb, :date, :price, :price_currency, :failed, :details)
  end
  
end

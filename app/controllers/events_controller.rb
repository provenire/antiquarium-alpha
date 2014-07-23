class EventsController < ApplicationController
  
  def index
    redirect_to artifacts_path
  end
  
  def show
    @event = Event.find_by_uuid!(params[:id])
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
  end
  
  def destroy
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

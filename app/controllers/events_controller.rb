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
    
  end
  
end

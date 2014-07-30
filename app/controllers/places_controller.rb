class PlacesController < ApplicationController
  
  def index
    @places = Place.order(:name).page params[:page]
  end
  
  def show
    @place = Place.find_by_uuid!(params[:id])
  end
  
  def new
    @place = Place.new
  end
  
  def create
    @place = Place.new(place_params)
    
    # Redirect
    if @place.save
      redirect_to @place
    else
      render 'new'
    end
  end
  
  def edit
  end
  
  def update
    @place = Place.find_by_uuid(params[:id])
    @place.update_attributes(params[:name] => params[:value])
    render nothing: true
  end
  
  def destroy
  end
  
  
  def history
    @place = Place.find_by_uuid!(params[:id])
    @versions = @place.versions.each{|v| v.whodunnit = User.find(v.whodunnit.to_i); v.changeset.delete(:updated_at) }
    @versions.sort!{|a,b| b.created_at <=> a.created_at }
  end
  
  
  def find
    query = params[:q]
    results = PgSearch.multisearch(query).where(searchable_type: ['Place'])
    respond_to do |format|
      format.json {
        render :json => results.map{|a| 
          {
            id:    a.searchable.uuid,
            text:  a.searchable.name
          }
        }
      }
    end
  end
  
  
  
  # Params
  private

  def place_params
    params.require(:place).permit(:name, :description)
  end
  
end

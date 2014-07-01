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
  
  
  # Params
  private

  def place_params
    params.require(:place).permit(:name, :description)
  end
  
end

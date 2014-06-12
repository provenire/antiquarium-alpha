class PhotosController < ApplicationController
  
	def index
	  @entity = Artifact.find_by_uuid(params[:artifact_id]) if params[:artifact_id]
	  @entity = Person.find_by_uuid(params[:person_id]) if params[:person_id]
	  @entity = Place.find_by_uuid(params[:place_id]) if params[:place_id]
    @photos = @entity.photos.order("created_at ASC").page params[:page]
  end
  
  
  def new
    @photo = Photo.new
  end


  def create
    # artifacts
    if params[:photo][:artifact_uuid]
      uuid   = params[:photo].delete(:artifact_uuid)
      object = Artifact.find_by_uuid(uuid)
    end
    
    # people
    if params[:photo][:person_uuid]
      uuid   = params[:photo].delete(:person_uuid)
      object = Person.find_by_uuid(uuid)
    end
    
    # places
    if params[:photo][:place_uuid]
      uuid   = params[:photo].delete(:place_uuid)
      object = Place.find_by_uuid(uuid)
    end
    
    photo = object.photos.create(photo_params)
    photo.save
    redirect_to object
  end
  
  
  def edit
    @photo = Photo.find(params[:id])
  end
  
  
  def update
    @photo = Photo.find(params[:id])
    if @photo.update_attributes(photo_params)
      redirect_to @photo
    else
      render edit_photo_path(@photo)
    end
  end


  def destroy
    @photo = Photo.find(params[:id])
    if @photo.destroy
      respond_to do |format|
        format.json { render :json => true }
        format.html { redirect_to photos_path }
      end
    end
  end


  def show
    @photo = Photo.find(params[:id])
  end
  
  
  # Params
  private
  
  def photo_params
    params.require(:photo).permit(:image, :comments)
  end
  
end

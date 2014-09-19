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
    
    @photo = object.photos.create(photo_params)
    redirect_to object
  end
  
  
  def edit
    @photo = Photo.find(params[:id])
  end
  
  
  def update
    @photo = Photo.find(params[:id])
    @photo.update_attributes(params[:name] => params[:value])
    render nothing: true
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
    gon.entity_id = @photo.id
  end
  
  
  def history
    @photo = Photo.find(params[:id])
    @versions = @photo.versions.each{|v| v.whodunnit = User.find(v.whodunnit); v.changeset.delete(:updated_at) }
    @versions.sort!{|a,b| b.created_at <=> a.created_at }
  end
  
  
  # Params
  private
  
  def photo_params
    params.require(:photo).permit(:image, :comments, :artifact_uuid, :person_uuid, :place_uuid)
  end
  
end

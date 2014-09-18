class ArtifactsController < ApplicationController
  
  def index
    @filters = filter_params
    @artifacts = Artifact.filter(filter_params).order(:name).page params[:page]
  end
  
  def show
    @artifact = Artifact.find_by_uuid!(params[:id])
  end
  
  def new
    @artifact = Artifact.new
  end
  
  def create
    # Make the artifact
    @artifact = Artifact.new(artifact_params)
    
    # Redirect
    if @artifact.save
      redirect_to @artifact
    else
      render 'new'
    end
  end
  
  def edit
  end
  
  def update
    @artifact = Artifact.find_by_uuid(params[:id])
    @artifact.update_attributes(params[:name] => params[:value])
    render nothing: true
  end
  
  def destroy
    @artifact = Artifact.find_by_uuid(params[:id])
    @artifact.destroy
    redirect_to '/artifacts'
  end
  
  def history
    @artifact = Artifact.find_by_uuid!(params[:id])
    @versions = @artifact.versions.each{|v| v.whodunnit = User.find(v.whodunnit.to_i); v.changeset.delete(:updated_at) }
    @versions.sort!{|a,b| b.created_at <=> a.created_at }
  end
  
  
  # Params
  private

  def artifact_params
    # Convert alternate names to array
    params[:artifact][:alternate_names] = params[:artifact][:alternate_names].split(",").map(&:strip)
    params.require(:artifact).permit(:name, {:alternate_names => []}, :description, :artist, :dimensions, :date_created)
  end
  
  def filter_params
    params.slice(:has_events, :has_photos, :has_artist, :has_dimensions, :has_date_created)
  end
  
end

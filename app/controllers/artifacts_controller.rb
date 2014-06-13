class ArtifactsController < ApplicationController
  
  def index
    @artifacts = Artifact.order(:name).page params[:page]
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
    redirect_to @artifact if @artifact.save
  end
  
  def edit
  end
  
  def update
    @artifact = Artifact.find_by_uuid(params[:id])
    @artifact.update_attributes(params[:name] => params[:value])
    render nothing: true
  end
  
  def destroy
  end
  
  
  # Params
  private

  def artifact_params
    # Convert alternate names to array
    params[:artifact][:alternate_names] = params[:artifact][:alternate_names].split(",").map(&:strip)
    params.require(:artifact).permit(:name, {:alternate_names => []}, :description, :artist, :dimensions, :date_created)
  end
  
end

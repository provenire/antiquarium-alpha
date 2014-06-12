class ArtifactsController < ApplicationController
  
  def index
  end
  
  def show
    @artifact = Artifact.find_by_uuid!(params[:id])
  end
  
  def new
    @artifact = Artifact.new
  end
  
  def create
    # Convert alternate names to array
    params[:artifact]["alternate_names"] = params[:artifact]["alternate_names"].split(",").map(&:strip)
    
    # Make the artifact
    @artifact = Artifact.new(artifact_params)
    
    # Redirect
    redirect_to @artifact if @artifact.save
  end
  
  def edit
  end
  
  def update
  end
  
  def destroy
  end
  
  
  # Params
  private

  def artifact_params
    params.require(:artifact).permit(:name, :alternate_names, :description, :artist, :dimensions, :date_created)
  end
  
end

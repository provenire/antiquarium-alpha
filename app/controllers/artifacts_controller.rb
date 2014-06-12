class ArtifactsController < ApplicationController
  
  def index
  end
  
  def show
  end
  
  def new
    @artifact = Artifact.new
  end
  
  def create
    # Convert alternate names to array
    params[:artifact]["alternate_names"] = params[:artifact]["alternate_names"].split(",").map(&:strip)
    
    # Make the artifact
    @artifact = Artifact.new(params[:artifact])
    
    # Redirect
    redirect_to @artifact if @artifact.save
  end
  
  def edit
  end
  
  def update
  end
  
  def destroy
  end
  
end

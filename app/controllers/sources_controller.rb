class SourcesController < ApplicationController
  
  def index
    @sources = Source.order(:name).page params[:page]
  end
  
  def show
    @source = Source.find_by_uuid!(params[:id])
  end
  
  def new
  end
  
  def create
  end
  
  def edit
  end
  
  def update
  end
  
  def destroy
  end
  
end

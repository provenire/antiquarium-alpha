class CitationsController < ApplicationController
  
  def new
    @event = Event.find_by_uuid!(params[:event_id])
    type = (['website', 'book', 'document'].include? params[:type]) ? params[:type].capitalize : 'Website'
    @source = type.constantize.new
    @citation = Citation.new
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

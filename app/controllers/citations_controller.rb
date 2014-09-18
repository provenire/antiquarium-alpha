class CitationsController < ApplicationController
  
  def show
    @citation = Citation.find(params[:id])
    redirect_to @citation.event
  end
  
  def new
    @event = Event.find_by_uuid!(params[:event_id])
    @type = (['website', 'book', 'document'].include? params[:type]) ? params[:type].capitalize : 'Website'
    @source = @type.constantize.new
    @citation = [@event, Citation.new]
  end
  
  def create
    @event = Event.find_by_uuid!(params[:event_id])
    @type = (['Website', 'Book', 'Document'].include? params[:type]) ? params[:type] : 'Website'

    case @type
    when 'Website'
      @source = @type.constantize.with_uri(params[:source][:uri]).first
      @source = Website.create(source_params) if !@source
    when 'Book'
      @source = @type.constantize.with_google_id(params[:source][:id]).first
      @source = Book.create(google_id: source_params[:id]) if !@source
    end

    @source.process
    @citation = @event.citations.new(citation_params)
    @citation.source = @source
    if @citation.save
      redirect_to @event
    else
      render 'new'
    end
  end
  
  def edit
  end
  
  def update
  end
  
  def destroy
    @citation = Citation.find(params[:id])
    if @citation.destroy
      redirect_to @citation.event
    end
  end
  
  
  private
  
  def citation_params
    params.require(:citation).permit(:content)
  end
  
  def source_params
    params.require(:source).permit(:uri, :id)
  end
  
end

class CitationsController < ApplicationController
  
  def show
    @citation = Citation.find(params[:id])
    redirect_to @citation.event
  end
  
  def new
    @event = Event.find_by_uuid!(params[:event_id])
    @type = (['website', 'book', 'document'].include? params[:type]) ? params[:type].capitalize : 'Website'
    @source = @type.constantize.new unless params[:document_uuid]
    @citation = [@event, Citation.new]
    
    if params[:document_uuid] && !Document.find_by_uuid(document_params[:document_uuid])
      @uploader = nil
      @document = Document.create(
        uuid: document_params[:document_uuid],
        name: document_params[:key].to_s.match(/^documents\/[a-f0-9-]*\/(.+?)$/)[1]
      )
      @document.update_attributes(key: document_params[:key].to_s.match(/^documents\/[a-f0-9-]*\/(.+?)$/)[1])
      @source = @document
      gon.document = { id: @document.uuid, text: @document.name }
    else
      gon.document = nil
      key = SecureRandom.uuid
      @uploader = Document.new(uuid: key).document
      @uploader.key = "documents/" + key + "/\${filename}"
      @uploader.success_action_redirect = new_event_citation_url(@event, type: 'document', document_uuid: key)
    end
  end
  
  def create
    @event = Event.find_by_uuid!(params[:event_id])
    @type = (['Website', 'Book', 'Document'].include? params[:type]) ? params[:type] : 'Website'
    p params

    case @type
    when 'Website'
      @source = @type.constantize.with_uri(params[:source][:uri]).first
      @source = Website.create(source_params) if !@source
    when 'Book'
      @source = @type.constantize.with_google_id(params[:source][:id]).first
      @source = Book.create(google_id: source_params[:id]) if !@source
    when 'Document'
      @source = Document.find_by_uuid(JSON.parse(params[:source][:id])["id"])
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
  
  def document_params
    params.permit(:key, :document_uuid, :bucket, :etag, :event_id, :type)
  end
  
end

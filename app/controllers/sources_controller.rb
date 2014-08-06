class SourcesController < ApplicationController
  
  def index
    @filters = filter_params
    @sources = Source.filter(filter_params).order(:name).page params[:page]
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
    @source = Source.find_by_uuid(params[:id])
    @source.update_attributes(params[:name] => params[:value])
    render nothing: true
  end
  
  def destroy
  end
  
  
  def history
    @source = Source.find_by_uuid!(params[:id])
    @versions = @source.versions.each{|v| v.whodunnit = User.find(v.whodunnit.to_i); v.changeset.delete(:updated_at) }
    @versions.sort!{|a,b| b.created_at <=> a.created_at }
  end
  
  
  def find_book
    query = params[:q]
    
    results = PgSearch.multisearch(query).where(searchable_type: ['Book'])
    results = results.map(&:searchable).map(&:searchable).to_a
    results = results.concat(Extractor::Book.search(query)).uniq {|i| i[:id] }
    
    respond_to do |format|
      format.json do
        render json: results
      end
    end
  end
  
  
  private
  
  def filter_params
    params.slice(:websites, :books, :documents, :has_events)
  end
  
end

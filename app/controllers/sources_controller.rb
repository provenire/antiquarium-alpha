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
  
end

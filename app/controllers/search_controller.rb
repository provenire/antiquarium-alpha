class SearchController < ApplicationController
  
  def index
    @query = params[:q]
    @filters    = filter_params.empty? ? {"artifact" => true, "person" => true, "place" => true, "source" => true} : filter_params
    @results    = PgSearch.multisearch(@query).where(searchable_type: @filters.keys.map(&:classify)).page(params[:page])
    @searchable = @results.map(&:searchable)
  end
  
  
  private
  
  def filter_params
    params.slice(:artifact, :person, :place, :source)
  end
  
end

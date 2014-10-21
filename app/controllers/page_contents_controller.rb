class PageContentsController < ApplicationController
  
  def update
    @content = PageContent.find(params[:id])
    @content.update_attributes(text: params[:value])
    render nothing: true
  end
  
end

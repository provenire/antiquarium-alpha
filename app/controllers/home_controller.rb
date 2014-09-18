class HomeController < ApplicationController
  
  def index
    @activities = PublicActivity::Activity.order(created_at: :desc).limit(5)
  end
  
end

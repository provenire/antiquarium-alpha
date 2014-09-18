class ApplicationController < ActionController::Base
  include PublicActivity::StoreController 
  
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  before_filter :authenticate_user!
  
  layout :layout_by_resource

  def layout_by_resource
    if devise_controller? && !user_signed_in?
      "session"
    else
      "application"
    end
  end
end

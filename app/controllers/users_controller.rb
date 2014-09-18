class UsersController < ApplicationController
  
  def profile
    redirect_to current_user
  end
  
  def show
    @user = User.find_by_id(params[:id]) || current_user
  end
  
  def settings
    @user = current_user
  end
  
end

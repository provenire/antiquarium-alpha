class UsersController < ApplicationController
  
  def profile
    redirect_to current_user
  end
  
  def show
    @user = User.find_by_id(params[:id]) || current_user
  end
  
  def edit
    @user = current_user
  end
  
  def update
    @user = User.find(params[:id])
    if @user == current_user && @user.update_without_password(user_params)
      flash! success: "User updated!"
      render 'edit'
    else
      flash! error: "Error updating user!"
      render :edit
    end
  end
  
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email)
  end
  
end

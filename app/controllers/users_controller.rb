class UsersController < ApplicationController
  def create
    session[:user_id] = User.create(user_params).id
    redirect_to root_path
  end

  def change_name
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to root_path
  end

  def user_params
    params.require(:user).permit(:name)
  end
end

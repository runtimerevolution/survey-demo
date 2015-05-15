class UsersController < ApplicationController
  def create
    session[:user_id] = User.create(user_params).id
    redirect_to :back
  end

  def user_params
    params.require(:user).permit(:name)
  end
end

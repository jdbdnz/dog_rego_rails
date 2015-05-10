class UsersController < ApplicationController
  before_filter :custom_authenticate_user!
  before_filter :load_user, only: [:show, :destroy, :edit]

  def index
    authorize :user
    @users = User.all
  end

  def destroy
    sign_out @user
    @user.registrations.destroy_all
    @user.dogs.destroy_all
    @user.destroy
    flash[:alert] = "Account has been deleted"
    redirect_to root_path and return
  end

end

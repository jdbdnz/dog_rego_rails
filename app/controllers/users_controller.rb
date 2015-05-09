class UsersController < ApplicationController
  
  before_filter :load_user, only: [:show]

  def index

  end

  def show

  end

  private

  def load_user
    @user = User.find params[:id]
  end

end

class ApplicationController < ActionController::Base
  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :permission_denied
  rescue_from Pundit::NotDefinedError, with: :not_found

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  def not_found
    render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false
  end

  def permission_denied
    flash[:notice] = "You do not have permission to view that page"
    unless current_user
      authenticate_user!
    else
      redirect_to root_url
    end
  end

  def authenticate_user!
    session[:user_return_to] = request.fullpath
    super
  end
  

  protected
  
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:first_name, :last_name, :email, :password, :password_confirmation, :postal_address) }
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:email, :password) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:first_name, :last_name, :email, :password, :password_confirmation, :current_password, :postal_address) }
  end

  def dog_params
    params.require(:dog).permit(:name, :breed, :date_of_birth).merge({ owner_id: @user.id })
  end

  private

  def load_dog
    @dog = @user.dogs.where("lower(dogs.name) = ?", (params[:dog_id] || params[:id]).downcase).first
    not_found unless @dog
  end

  def load_user
    @user = User.find(params[:user_id] || params[:id])
  end


end

class RegistrationsController < ApplicationController
  before_filter :authenticate_user!

  before_filter :load_user
  before_filter :load_dog
  
  def new
    @registration = Registration.new dog_id: @dog.id
  end

  def create
    months = params[:registration_length].to_i
    registration_params = {
      dog_id:     @dog.id,
      fee:        Registration::REGISTRATION_PERIOD_PRICES[months],
      valid_from: @dog.new_registration_valid_from,
      valid_until: @dog.new_registration_valid_from + months.months
    }
    if @registration = Registration.create(registration_params)
      flash[:notice] = "#{@dog.name}'s registration has been renewed."
      RegistrationMailer.registered(@registration).deliver!
      redirect_to user_dog_path(@user,@dog) and return
    else
      flash[:alert] = "Something went wrong. Please try again."
      render 'new'
    end
  end

end
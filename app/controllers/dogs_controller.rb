class DogsController < ApplicationController
  before_filter :custom_authenticate_user!

  before_filter :load_user
  before_filter :load_dog, only: [:show, :edit, :update, :destroy]

  def index
    @dogs = @user.dogs
  end

  def update
    if @dog.update_attributes dog_params
      flash[:notice] = "#{@dog.name}'s details have been saved."
      redirect_to user_dog_path(@user,@dog) and return
    else
      render 'edit'
    end
  end

  def new
    @dog = Dog.new owner: @user
  end

  def create
    @dog = Dog.new dog_params
    registration_period = params[:registration_period].to_i
    if @user.dogs.where("lower(dogs.name) = ?", @dog.name.downcase).present?
      valid = false
      flash[:alert] = "\"#{@dog.name}\" is already registered to you. Did you mean to renew their registration instead?"
    else
      @registration = Registration.create({
        dog: @dog = Dog.create(dog_params) ,
        valid_from: Date.current,
        valid_until: Date.current.advance(months: registration_period),
        fee: Registration::REGISTRATION_PERIOD_PRICES[registration_period]
      })
      Nofly.for(@registration).created if @registration.valid?
      valid = @dog.valid?
    end
    render 'new' and return unless valid
    flash[:notice] = "Success! \"#{@dog.name}\" has been registered for the next #{registration_period} months. Please follow payment instructions below."
    redirect_to user_dog_path(@user,@dog)
  end

  def destroy
    @dog.registrations.destroy_all
    @dog.destroy
    flash[:alert] = "All records of #{@dog.name} has been deleted"
    redirect_to user_path(@user) and return
  end

end

class DogsController < ApplicationController
  
  before_filter :load_user
  before_filter :load_dog, only: [:show, :edit, :update]


  def index
    @dogs = @user.dogs
  end

  def show
  end

  def edit
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
      Registration.create({
        dog: @dog,
        valid_from: Date.current,
        valid_till: Date.current.advance(months: registration_period),
        fee: Registration::REGISTRATION_PERIOD_PRICES[registration_period]
      })
      valid = @dog.valid?
    end
    render 'new' and return unless valid
    flash[:notice] = "Success! \"#{@dog.name}\" has been registered for the next #{registration_period} months. Please follow payment instructions below."
    redirect_to user_dog_path(@user,@dog)
  end

  private

  def load_dog
    @dog = Dog.find params[:id]
  end

  def load_user
    @user = User.find params[:user_id]
  end

  def dog_params
    dog_attr = params.require(:dog).permit(:name, :breed, :date_of_birth)
    dog_attr[:owner_id] = @user.id
    dog_attr
  end

end

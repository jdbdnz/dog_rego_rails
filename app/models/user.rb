class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  serialize :postal_address

  has_many :dogs
  has_many :registrations, through: :dogs

  def postal_address_formatted
    postal_address['results'][0]['formatted_address']
  end

end

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  serialize :postal_address

  has_many :dogs, foreign_key: :owner_id
  has_many :registrations, through: :dogs

  def postal_address_formatted
    if postal_address.is_a? String
      # user continued without selecting a geocoded suggestion
      # good to have this ability in case the address from Google isn't correct
      postal_address
    else
      begin
        postal_address['results'][0]['formatted_address']
      rescue
        nil
      end
    end
  end

end

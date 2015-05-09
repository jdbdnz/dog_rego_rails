class Dog < ActiveRecord::Base
  belongs_to :owner, class_name: "User"
  has_many :registrations

  def age
    Date.current.year - self.date_of_birth.year
  end

  def current_registration
    registrations.current.first
  end

  def current_registration?
    current_registration.present?
  end
  
end

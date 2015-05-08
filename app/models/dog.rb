class Dog < ActiveRecord::Base
  belongs_to :owner, class_name: "User"
  has_many :registrations

  def age
    Date.current.year - self.date_of_birth.year
  end
end

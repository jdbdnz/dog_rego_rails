class Registration < ActiveRecord::Base
  belongs_to :dog
  delegate :name, :breed, :date_of_birth, to: :dog
end
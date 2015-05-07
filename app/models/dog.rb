class Dog < ActiveRecord::Base
  has_one :owner
end

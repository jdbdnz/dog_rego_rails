FactoryGirl.define do
  factory :dog do
    owner
    name 'Log'
    breed 'Oak'
    date_of_birth Date.new(2012, 1, 1)
  end

end

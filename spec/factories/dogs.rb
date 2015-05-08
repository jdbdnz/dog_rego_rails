FactoryGirl.define do
  factory :dog do
    owner         { |i| i.association(:user) }
    registrations { |i| [i.association(:expired_registration), i.association(:registration)] }

    name 'Log'
    breed 'Oak'
    date_of_birth Date.new(2012, 1, 1)
  end

end

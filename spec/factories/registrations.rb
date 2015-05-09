FactoryGirl.define do
  factory :registration do
    dog         { |i| i.association(:dog) }

    valid_from (Date.current)
    valid_till (Date.current + 3.months)
    paid true

    factory :payment_pending do
      paid false
    end

    factory :expired_registration do
      valid_from (Date.current - 3.months - 1.day)
      valid_till (Date.current - 1.day)
    end
    
  end

end

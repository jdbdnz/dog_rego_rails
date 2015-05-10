FactoryGirl.define do
  factory :registration do
    dog
    valid_from  (Date.current)
    valid_until (Date.current + 3.months)
    paid        true
    fee         Registration.fee_for_months(3)

    factory :registration_payment_pending do
      paid false
      valid_from (Date.current + 3.months)
      valid_until (Date.current + 6.months)
    end

    factory :expired_registration do
      valid_from (Date.current - 3.months - 1.day)
      valid_until (Date.current - 1.day)
    end
    
  end

end

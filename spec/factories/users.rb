FactoryGirl.define do

  sequence(:email) { |n| "example_#{n}@example.com" }
  sequence(:password) { Devise.friendly_token.first(8) }

  factory :user do
    first_name      'Example'
    last_name       'User'
    password         { generate(:password) }
    email            { generate(:email) }
    postal_address  ({"results"=>   [{"address_components"=>      [{"long_name"=>"100", "short_name"=>"100", "types"=>["street_number"]},       {"long_name"=>"Twin Peaks Hwy", "short_name"=>"Twin Peaks Hwy", "types"=>["route"]},       {"long_name"=>"Twin Peaks", "short_name"=>"Twin Peaks", "types"=>["locality", "political"]},       {"long_name"=>"Twin Peaks County", "short_name"=>"Twin Peaks County", "types"=>["administrative_area_level_2", "political"]},       {"long_name"=>"Washington", "short_name"=>"WA", "types"=>["administrative_area_level_1", "political"]},       {"long_name"=>"UnitedStates", "short_name"=>"US", "types"=>["country", "political"]},       {"long_name"=>"98203", "short_name"=>"98203", "types"=>["postal_code"]}],     "formatted_address"=>"100 Twin Peaks Highway, Twin Peaks, WA 98203, USA",     "geometry"=>      {"location"=>{"lat"=>37.4224764, "lng"=>-122.0842499},       "location_type"=>"ROOFTOP",       "viewport"=>{"northeast"=>{"lat"=>37.4238253802915, "lng"=>-122.0829009197085}, "southwest"=>{"lat"=>37.4211274197085, "lng"=>-122.0855988802915}}},     "place_id"=>"ChIJ2eUgeAK6j4ARbn5u_wAGqWA",     "types"=>["street_address"]}],  "status"=>"OK"})

    factory :admin do
      last_name "Admin"
      email 'admin@admin.com'
      password 'password'
      role 'admin'
    end

    factory :owner do
      first_name      'Log'
      last_name       'Lady'
    end

  end

end

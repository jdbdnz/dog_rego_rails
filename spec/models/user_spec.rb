require 'rails_helper'

RSpec.describe User, type: :model do
  
  let(:user) { FactoryGirl.create(:user) }

  # TODO: split this into a few more specific tests so we don't have to depend on the factory not changing
  it "should return formatted address string from postal_address json" do
    expect( user.postal_address_formatted ).to eq "100 Twin Peaks Highway, Twin Peaks, WA 98203, USA"
  end

end

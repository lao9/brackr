require 'rails_helper'

describe CrossStreetService do
  it "returns cross streets for a specified lat long" do
    VCR.use_cassette('cross_street_service') do
      coordinates = {lat: 39.749598000000006, long: -105.0004297}
      cross_streets = CrossStreetService.find_by_coordinates(coordinates)

      expect(cross_streets).to be_a(String)
      expect(cross_streets).to eq("15th St & Blake St")
    end
  end
end

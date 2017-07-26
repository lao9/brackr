require 'rails_helper'

describe "Bracks API" do
  attr_reader :first_closest, :first_furthest, :second_closest, :second_furthest
  before :all do
    40.times { |n| Brack.create(lat: latitudes[n],
                                long: longitudes[n],
                                cross_streets: cross_streets[n],
                                owner: "City of Denver")
              }
    @first_closest = Brack.find(26)
    @first_furthest = Brack.find(27)
    @second_closest = Brack.find(36)
    @second_furthest = Brack.find(22)
  end
  context "no params are passed" do
    it "returns JSON of 20 racks sorted by distance from Turing School" do
      get '/api/v1/bracks'

      bracks = JSON.parse(response.body, symbolize_names: true)
      first_brack = bracks.first
      last_brack = bracks.last

      expect(response).to be_success
      expect(bracks).to be_an(Array)
      expect(bracks.count).to eq(20)
      expect(first_brack).to be_a(Hash)

      expect(first_brack).to have_key(:id)
      expect(first_brack).to have_key(:lat)
      expect(first_brack).to have_key(:long)
      expect(first_brack).to have_key(:distance)

      expect(first_brack[:id]).to eq(first_closest.id)
      expect(last_brack[:id]).to eq(first_furthest.id)
      expect(first_brack[:distance]).to be < last_brack[:distance]
    end
  end
  context "lat and long params are passed" do
    it "returns JSON of 20 racks sorted by distance from given location" do

      get '/api/v1/bracks', params: {latlng: "39.756586,-104.981311"}

      bracks = JSON.parse(response.body, symbolize_names: true)
      first_brack = bracks.first
      last_brack = bracks.last

      expect(response).to be_success
      expect(bracks).to be_an(Array)
      expect(bracks.count).to eq(20)
      expect(first_brack).to be_a(Hash)

      expect(first_brack).to have_key(:id)
      expect(first_brack).to have_key(:lat)
      expect(first_brack).to have_key(:long)
      expect(first_brack).to have_key(:distance)

      expect(first_brack[:id]).to eq(second_closest.id)
      expect(last_brack[:id]).to eq(second_furthest.id)
      expect(first_brack[:distance]).to be < last_brack[:distance]
    end
  end
end

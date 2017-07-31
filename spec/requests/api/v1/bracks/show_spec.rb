require 'rails_helper'

describe "Single Brack Show API" do
  let(:brack) {create(:brack)}
  context "without latlng params" do
    it "returns id, lat, lng, and distance of a single rack" do

      get "/api/v1/bracks/#{brack.id}"

      raw_brack = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_success
      expect(raw_brack).to be_a(Hash)

      expect(raw_brack).to have_key(:id)
      expect(raw_brack).to have_key(:lat)
      expect(raw_brack).to have_key(:long)
      expect(raw_brack).to have_key(:distance)

      expect(raw_brack[:id]).to eq(brack.id)
      expect(raw_brack[:distance]).to eq(0.00)
    end
  end
  context "with latlng params" do
    it "returns id, lat, lng, and distance of a single rack" do

      get "/api/v1/bracks/#{brack.id}", params: {latlng: "39.756586,-104.981311"}

      raw_brack = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_success
      expect(raw_brack).to be_a(Hash)

      expect(raw_brack).to have_key(:id)
      expect(raw_brack).to have_key(:lat)
      expect(raw_brack).to have_key(:long)
      expect(raw_brack).to have_key(:distance)

      expect(raw_brack[:id]).to eq(brack.id)
      expect(raw_brack[:distance]).to eq(1.1257645516785693)
    end

  end
end

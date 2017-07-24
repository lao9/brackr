require 'rails_helper'

RSpec.describe Brack, type: :model do
  let(:brack) {create(:brack)}

  describe "attributes" do
    it "responds to cross_streets" do
      expect(brack).to respond_to(:cross_streets)
      expect(brack).to respond_to(:lat)
      expect(brack).to respond_to(:long)
      expect(brack).to respond_to(:owner)
    end
    it "responds to lat and long" do
      expect(brack).to respond_to(:lat)
      expect(brack).to respond_to(:long)
    end
    it "responds to owner" do
      expect(brack).to respond_to(:owner)
    end

    describe "validations" do
      it { expect(brack).to validate_presence_of(:lat)}
      it { expect(brack).to validate_presence_of(:long)}
    end
  end
end

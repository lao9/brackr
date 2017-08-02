require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) {create(:user)}

  describe "attributes" do
    it "responds to email" do
      expect(user).to respond_to(:email)
      expect(user).to respond_to(:first_name)
      expect(user).to respond_to(:last_name)
      expect(user).to respond_to(:organization)
    end
    it "responds to password digest" do
      expect(user).to respond_to(:password_digest)
    end
  end

  describe "validations" do
    it { expect(user).to validate_presence_of(:email)}
    it { expect(user).to validate_presence_of(:first_name)}
    it { expect(user).to validate_presence_of(:last_name)}
    it { expect(user).to validate_uniqueness_of(:email)}
  end

end

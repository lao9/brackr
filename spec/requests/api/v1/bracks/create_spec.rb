require 'rails_helper'

describe "Bracks Create API" do
  let(:user1) {create(:user)}
  let(:user2) {create(:user, organization: nil)}
  let(:brack) {build(:brack, cross_streets: nil)}
  it "adds a new brack location owned by user with an organization" do
    expect(Brack.count).to eq(0)

    creation_params = {
      user_id: user1.id,
      lat: brack.lat,
      long: brack.long,
      token: ENV['POST_TO_BRACKS_KEY']
    }

    post '/api/v1/bracks', params: {brack: creation_params}

    expect(response).to be_success
    expect(Brack.count).to eq(1)

    new_brack = Brack.all[0]

    expect(new_brack.lat).to eq(39.749598)
    expect(new_brack.long).to eq(brack.long)
    expect(new_brack.cross_streets).to eq("15th St & Blake St")
    expect(new_brack.owner).to eq(user1.organization)
  end
  it "adds a new brack location owned by user without an organization" do
    expect(Brack.count).to eq(0)

    creation_params = {
      user_id: user2.id,
      lat: brack.lat,
      long: brack.long,
      token: ENV['POST_TO_BRACKS_KEY']
    }

    post '/api/v1/bracks', params: {brack: creation_params}

    expect(response).to be_success
    expect(Brack.count).to eq(1)

    new_brack = Brack.all[0]
    user_name = "#{user2.first_name} #{user2.last_name[0]}."

    expect(new_brack.lat).to eq(39.749598)
    expect(new_brack.long).to eq(brack.long)
    expect(new_brack.cross_streets).to eq("15th St & Blake St")
    expect(new_brack.owner).to eq(user_name)
  end
end

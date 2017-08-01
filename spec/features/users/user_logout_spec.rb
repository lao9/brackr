require 'rails_helper'

feature "user can log out" do
  let(:user) {create(:user)}
  context "as a logged in user" do
    scenario "user is logged in and clicks logout" do
      visit login_path

      within ".well" do        
        fill_in 'session[email]', with: user.email
        fill_in 'session[password]', with: user.password
        click_on "Log In"
      end

      click_on "Log Out"
      expect(page).to have_content("Goodbye!")
      expect(page).to have_content("Log In")
      expect(page).to_not have_content("Log Out")
    end
  end
end

require 'rails_helper'

feature "login process" do
  let(:user) {create(:user)}
  context "as an unauthenticated user" do
    scenario "can navigate to login path" do
      visit root_path

      click_on "Log In"

      expect(current_path).to eq(login_path)
    end
    scenario "can login with email and password" do
      visit login_path

      within ".well" do
        fill_in "session[email]", with: user.email
        fill_in "session[password]", with: user.password
        click_on "Log In"
      end

      expect(page).to have_content("Welcome!")
      expect(current_path).to eq(bracks_path)
      expect(page).to have_content("Log Out")

      expect(page).to_not have_content "Sign Up"
      expect(page).to_not have_content "Log In"
    end
    scenario "they provide invalid email" do
      visit login_path

      within ".well" do
        fill_in "session[email]", with: "lollllll@lol.com"
        fill_in "session[password]", with: user.password
        click_button "Log In"
      end

      expect(current_path).to eq(login_path)
      expect(page).to have_content("Invalid Username or Password!")

      expect(page).to_not have_content "Log Out"
      expect(page).to have_content "Sign Up"
      expect(page).to have_content "Log In"
    end
    scenario "they provide invalid password" do
      visit login_path

      within ".well" do
        fill_in "session[email]", with: user.email
        fill_in "session[password]", with: "blah"
        click_on "Log In"
      end

      expect(current_path).to eq(login_path)
      expect(page).to have_content("Invalid Username or Password!")

      expect(page).to_not have_content "Log Out"
      expect(page).to have_content "Sign Up"
      expect(page).to have_content "Log In"
    end
    scenario "they provide blank email" do
      visit login_path

      within ".well" do
        fill_in "session[email]", with: ""
        fill_in "session[password]", with: user.password
        click_button "Log In"
      end

      expect(current_path).to eq(login_path)
      expect(page).to have_content("Invalid Username or Password!")

      expect(page).to_not have_content "Log Out"
      expect(page).to have_content "Sign Up"
      expect(page).to have_content "Log In"
    end
    scenario "they provide blank password" do
      visit login_path

      within ".well" do
        fill_in "session[email]", with: user.email
        fill_in "session[password]", with: ""
        click_button "Log In"
      end

      expect(current_path).to eq(login_path)
      expect(page).to have_content("Invalid Username or Password!")

      expect(page).to_not have_content "Log Out"
      expect(page).to have_content "Sign Up"
      expect(page).to have_content "Log In"
    end
  end
end

require 'rails_helper'

feature "default map landing page" do
  context "as any user" do
    scenario "when I navigate to the root page" do
      visit '/'

      within ".navbar-brand" do
        expect(page).to have_content("Brackr")
      end

      # within ".map-box" do
      #   expect(page).to have_content("Find nearest bike rack...")
      # end
      #
      # expect(page).to have_content("Show nearest racks")
    end
  end
end

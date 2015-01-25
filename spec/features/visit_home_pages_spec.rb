require 'spec_helper'

feature "TrackingTagForIndex", type: :feature do
  scenario "An anonymous user vists the home page" do
    visit "/"
    # Sanity check
    expect(page).to have_content "Powered by Spree"

    expect(page.body).to include "<!-- Piwik -->"
  end
end

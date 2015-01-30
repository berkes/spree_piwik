require 'spec_helper'

feature "TrackingTagForIndex", type: :feature do
  scenario "An anonymous user is tracked on the home page" do
    visit "/"

    # Sanity check
    expect(page).to have_content "Powered by Spree"

    tag_component = PiwikTagComponent.new
    expect(tag_component).to be_in_html
    expect(tag_component.tracker_url_assigment).to include('example.com')
    expect(tag_component.to_s).to eq fixture('index_example_com.html')
  end
end

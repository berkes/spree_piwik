require 'spec_helper'

feature "TrackingTagForProduct", type: :feature do
  before do
    @product = FactoryGirl.create(:product, sku: 'SKU-1', name: 'RoR Shirt')
  end

  # As a customer
  # I want to send stats with the product's attributes to piwik
  # So that I can allow Piwik to process reports on SKU and products.
  scenario "An anonymous user is tracked on a product page" do
    # TODO replace with visit "product/slug"
    visit "/"
    click_link(@product.name)

    # Sanity check
    expect(page).to have_content @product.name

    tag_component = PiwikTagComponent.new
    expect(tag_component).to be_in_html
    expect(tag_component.to_s).to include 'setEcommerceView'
    expect(tag_component.to_s).to eq fixture('product_example_com.html')
  end
end

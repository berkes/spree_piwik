require "spec_helper"

feature "TrackingTagForProduct", type: :feature do
  # As a shop-owner
  # I want to send stats with the product"s attributes to piwik
  # So that I can allow Piwik to process reports on SKU and products.
  scenario "An anonymous user is tracked on a product page" do
    @product = create(:product, sku: "SKU-1", name: "RoR Shirt")
    visit "/products/#{@product.slug}"

    # Sanity check
    expect(page).to have_content @product.name

    tag_component = PiwikTagComponent.new
    expect(tag_component).to be_in_html
    expect(tag_component.to_s).to include "setEcommerceView"
    expect(tag_component.as_ecma).to eq fixture("product_example_com.js")
  end

  # As a shop-owner
  # I want to send the categories in a product to piwik
  # So that can filter stats in Piwik on categories
  scenario "An anonymous user is tracked on a product page with categories" do
    taxons = [
      create(:taxon, name: "shirts"),
      create(:taxon, name: "ror"),
      create(:taxon, name: "webdev"),
    ]
    @product = create(:product, sku: "SKU-1", name: "RoR Shirt", taxons: taxons)

    visit "/products/#{@product.slug}"

    tag_component = PiwikTagComponent.new
    expect(tag_component).to be_in_html
    expect(tag_component.to_s).to include "setEcommerceView"
    expect(tag_component.as_ecma).to eq fixture("product_with_categories.js")
  end
end

require 'spec_helper'

feature "InteractWithCart", type: :feature do
  scenario "An anonymous user adds a product to the cart" do
    @product = FactoryGirl.create(:product, sku: 'SKU-1', name: 'RoR Shirt')
    visit "products/#{@product.slug}"
    click_button "Add To Cart"

    tag_component = PiwikTagComponent.new
    expect(tag_component.to_s).to eq fixture('product_added_to_cart.html')
  end
end

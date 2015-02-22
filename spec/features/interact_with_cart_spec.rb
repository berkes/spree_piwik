require 'spec_helper'

feature "InteractWithCart", type: :feature do
  scenario "An anonymous user adds a product to the cart" do
    @product = FactoryGirl.create(:product, sku: 'SKU-1', name: 'RoR Shirt')
    visit "products/#{@product.slug}"
    click_button "Add To Cart"

    tag_component = PiwikTagComponent.new
    expect(tag_component.as_ecma).to eq fixture('product_added_to_cart.js')
  end

  scenario "An anonymous user adds multiple products to the cart" do
    @shirt = FactoryGirl.create(:product, sku: 'SKU-1', name: 'RoR Shirt')
    visit "products/#{@shirt.slug}"
    click_button "Add To Cart"
    @sticker = FactoryGirl.create(:product, sku: 'SKU-2', name: 'RoR Sticker', price: 0.99)
    visit "products/#{@sticker.slug}"
    click_button "Add To Cart"

    tag_component = PiwikTagComponent.new
    expect(tag_component.as_ecma).to eq fixture('multiple_products_in_cart.js')
  end
end

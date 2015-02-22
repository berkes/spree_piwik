require "spec_helper"

feature "InteractWithCart", type: :feature do
  scenario "An anonymous user adds a product to the cart" do
    @product = FactoryGirl.create(:product, sku: "SKU-1", name: "RoR Shirt")
    visit "products/#{@product.slug}"
    click_button "Add To Cart"

    tag_component = PiwikTagComponent.new
    expect(tag_component.as_ecma).to eq fixture("one_product_in_cart.js")
  end

  scenario "An anonymous user adds multiple products to the cart" do
    @shirt = FactoryGirl.create(:product, sku: "SKU-1", name: "RoR Shirt")
    visit "products/#{@shirt.slug}"
    click_button "Add To Cart"
    @sticker = FactoryGirl.create(:product, sku: "SKU-2", name: "RoR Sticker", price: 0.99)
    visit "products/#{@sticker.slug}"
    click_button "Add To Cart"

    tag_component = PiwikTagComponent.new
    expect(tag_component.as_ecma).to eq fixture("multiple_products_in_cart.js")
  end

  scenario "An anonymous user removes a product from cart" do
    @shirt = FactoryGirl.create(:product, sku: "SKU-1", name: "RoR Shirt")
    visit "products/#{@shirt.slug}"
    click_button "Add To Cart"
    @sticker = FactoryGirl.create(:product, sku: "SKU-2", name: "RoR Sticker", price: 0.99)
    visit "products/#{@sticker.slug}"
    click_button "Add To Cart"

    fill_in(:order_line_items_attributes_1_quantity, with: 0)
    click_button "Update"

    tag_component = PiwikTagComponent.new
    expect(tag_component.as_ecma).to eq fixture("one_product_in_cart.js")
  end

  scenario "An anonymous user empties a cart" do
    @shirt = FactoryGirl.create(:product, sku: "SKU-1", name: "RoR Shirt")
    visit "products/#{@shirt.slug}"
    click_button "Add To Cart"
    click_button "Empty Cart"

    tag_component = PiwikTagComponent.new
    expect(tag_component.as_ecma).to eq fixture("empty_cart.js")
  end
end

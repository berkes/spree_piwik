require "spec_helper"

feature "OrderProcess", type: :feature do
  scenario "An anonymous gets a checkout confirmation" do
    @order = create(:completed_order_with_totals, number: 'R1337', line_items_count: 2)
    @order.products.first.update_attributes(name: "RoR Shirt")
    @order.products.second.update_attributes(name: "RoR Sticker")

    # FactoryGirl is not very suited for these setups.
    # So we stick with the default of 100 for shipment 0 for tax.
    # Sanity check.
    expect(@order.ship_total).to eq 100.0
    expect(@order.tax_total).to eq 0.0

    visit "orders/#{@order.number}/token/#{@order.guest_token}"

    tag_component = PiwikTagComponent.new
    expect(tag_component.as_ecma).to eq fixture("completed_order.js")
  end
end

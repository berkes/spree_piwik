require "spec_helper"

feature "OrderProcess", type: :feature do
  let(:user) { create(:user) }
  let(:order) { OrderWalkthrough.up_to(:delivery) }

  before do
    order.update_attribute(:number, 'R1337')
    order.products.update_all(name: 'RoR Shirt')
    allow_any_instance_of(Spree::CheckoutController).to receive_messages(current_order: order)
    allow_any_instance_of(Spree::CheckoutController).to receive_messages(try_spree_current_user: user)
    allow_any_instance_of(Spree::OrdersController).to receive_messages(try_spree_current_user: user)

    visit spree.checkout_state_path(:delivery)
    click_button "Save and Continue"
    click_button "Save and Continue"
  end

  scenario "An anonymous gets a checkout confirmation" do
    tag_component = PiwikTagComponent.new
    expect(tag_component.as_ecma).to eq fixture("completed_order.js")
  end
end

require 'spec_helper'

describe Spree::Piwik::Client, type: :model do
  it 'fetches the url from preferences' do
    allow(Spree::Piwik::Config).to receive(:preferred_piwik_url).and_return 'piwik.example.com'
    expect(subject.url).to eq 'piwik.example.com'
  end

  it 'fetches the piwik_id from preferences' do
    allow(Spree::Piwik::Config).to receive(:preferred_piwik_id).and_return 1337
    expect(subject.site_id).to eq 1337
  end

  describe '#product' do
    context 'when it has a product' do
      before { subject.product = double(:product, sku: 'sku', name: nil, price: nil, taxons: []) }
      it 'is an line_item with that product' do
        expect(subject.product).to be_a_kind_of Spree::Piwik::LineItem
        expect(subject.product.sku).to eq 'sku'
      end
    end

    context 'when it has no product' do
      before { subject.product = nil }
      it 'is nil' do
        expect(subject.product).to be_nil
      end
    end
  end

  describe '#order' do
    it 'can be set on initialisation' do
      order = double(:order)
      expect(Spree::Piwik::Client.new(order: order).order).to eq order
    end
  end

  describe '#ecommerce_items' do
    context 'when order is set' do
      it 'has the ine_items in the order' do
        product = double(:product, sku: 'sku', name: 'name', price: 'price', quantity: 1)
        subject.order = double(:order, line_items: [product])
        expect(subject.ecommerce_items.first).to be_a_kind_of Spree::Piwik::LineItem
        expect(subject.ecommerce_items.first.sku).to eq 'sku'
        expect(subject.ecommerce_items.first.quantity).to eq 1
      end
    end
  end

  describe '#track_cart_update?' do
    context 'when order with state cart is set' do
      it 'is true' do
        order = double(:order, cart?: true)
        expect(Spree::Piwik::Client.new(order: order).track_cart_update?).to eq true
      end
    end

    context 'when order state is not cart' do
      it 'is false' do
        order = double(:order, cart?: false)
        expect(Spree::Piwik::Client.new(order: order).track_cart_update?).to eq false
      end
    end

    context 'when order is empty' do
      it 'is false' do
        expect(subject.track_cart_update?).to eq false
      end
    end
  end

  describe "#track_ecommerce_order?" do
    context 'when order with state complete is set' do
      it 'is true' do
        order = double(:order, complete?: true)
        expect(Spree::Piwik::Client.new(order: order).track_ecommerce_order?).to eq true
      end
    end

    context 'when order state is not complete' do
      it 'is false' do
        order = double(:order, complete?: false)
        expect(Spree::Piwik::Client.new(order: order).track_ecommerce_order?).to eq false
      end
    end
    context 'when order is empty' do
      it 'is false' do
        expect(subject.track_ecommerce_order?).to eq false
      end
    end
  end
end

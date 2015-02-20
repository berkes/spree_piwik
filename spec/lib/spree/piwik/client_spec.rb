require 'spec_helper'

describe Spree::Piwik::Client do
  subject { Spree::Piwik::Client.new }
  it 'fetches the url from preferences' do
    allow(Spree::Piwik::Config).to receive(:preferred_piwik_url).and_return 'piwik.example.com'
    expect(subject.url).to eq 'piwik.example.com'
  end

  it 'fetches the piwik_id from preferences' do
    allow(Spree::Piwik::Config).to receive(:preferred_piwik_id).and_return 1337
    expect(subject.site_id).to eq 1337
  end

  describe '#product' do
    it 'can be set on initialisation' do
      product = double(:product)
      expect(Spree::Piwik::Client.new(product: product).product).to eq product
    end
  end

  describe '#order' do
    it 'can be set on initialisation' do
      order = double(:order)
      expect(Spree::Piwik::Client.new(order: order).order).to eq order
    end
  end

  describe '#categories' do
    context 'when it has a product with taxons' do
      it 'returns the name of the taxons of the product' do
        taxon   = double(:taxon, name: 'shirts')
        product = double(:product, taxons: [taxon])
        expect(Spree::Piwik::Client.new(product: product).categories).to match_array ['shirts']
      end
    end

    context 'when it has a product with more then 5 taxons' do
      it 'limits the categories to five items' do
        taxon   = double(:taxon, name: 'shirts')
        product = double(:product, taxons: Array.new(6, taxon))
        expect(Spree::Piwik::Client.new(product: product).categories.length).to eq 5
      end
    end

    context 'when it has a product with no taxons' do
      it 'returns an empty array' do
        product = double(:product, taxons: [])
        expect(Spree::Piwik::Client.new(product: product).categories).to eq []
      end
    end

    context 'when it has no product' do
      it 'returns an empty array' do
        expect(Spree::Piwik::Client.new.categories).to eq []
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

end

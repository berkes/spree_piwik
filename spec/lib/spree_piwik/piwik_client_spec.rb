require 'spec_helper'

describe SpreePiwik::PiwikClient do
  subject { SpreePiwik::PiwikClient.new }
  it 'fetches the url from preferences' do
    allow(Spree::Config).to receive(:preferred_piwik_url).and_return 'piwik.example.com'
    expect(subject.url).to eq 'piwik.example.com'
  end

  it 'fetches the piwik_id from preferences' do
    allow(Spree::Config).to receive(:preferred_piwik_id).and_return 1337
    expect(subject.site_id).to eq 1337
  end

  describe '#product' do
    it 'can be set on initialisation' do
      product = double(:product)
      expect(SpreePiwik::PiwikClient.new(product: product).product).to eq product
    end
  end

  describe '#categories' do
    context 'when it has a product with taxons' do
      it 'returns the name of the taxons of the product' do
        taxon   = double(:taxon, name: 'shirts')
        product = double(:product, taxons: [taxon])
        expect(SpreePiwik::PiwikClient.new(product: product).categories).to match_array ['shirts']
      end
    end

    context 'when it has a product with more then 5 taxons' do
      it 'limits the categories to five items' do
        taxon   = double(:taxon, name: 'shirts')
        product = double(:product, taxons: Array.new(6, taxon))
        expect(SpreePiwik::PiwikClient.new(product: product).categories.length).to eq 5
      end
    end

    context 'when it has a product with no taxons' do
      it 'returns an empty array' do
        product = double(:product, taxons: [])
        expect(SpreePiwik::PiwikClient.new(product: product).categories).to eq []
      end
    end

    context 'when it has no product' do
      it 'returns an empty array' do
        expect(SpreePiwik::PiwikClient.new.categories).to eq []
      end
    end

  end
end

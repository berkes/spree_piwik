require 'spec_helper'

describe Spree::Piwik::LineItem, type: :model do
  describe '.from_product_ish' do
    let(:product) { double(:product, sku: 'sku', name: 'name', price: 'price', quantity: 'quantity', taxons: []) }
    let(:line_item) { Spree::Piwik::LineItem.from_product_ish(product) }

    it 'instantiates self from a line_item-ish item' do
      expect(line_item).to be_a_kind_of Spree::Piwik::LineItem
      expect(line_item.sku).to eq 'sku'
      expect(line_item.name).to eq 'name'
      expect(line_item.price).to eq 'price'
      expect(line_item.quantity).to eq 'quantity'
      expect(line_item.categories).to eq []
    end

    describe '#categories' do
      let(:taxon) { double(:taxon, name: 'shirts') }
      context 'when it has a product with taxons' do
        before { allow(product).to receive(:taxons).and_return([taxon]) }
        it 'returns the name of the taxons of the product' do
          expect(line_item.categories).to match_array ['shirts']
        end
      end

      context 'when it has a product with more then 5 taxons' do
        before { allow(product).to receive(:taxons).and_return(Array.new(6, taxon)) }
        it 'limits the categories to five items' do
          expect(line_item.categories.length).to eq 5
        end
      end

      context 'when it has a product with no taxons' do
        before { allow(product).to receive(:taxons).and_return([]) }
        it 'returns an empty array' do
          expect(line_item.categories).to eq []
        end
      end
    end
  end

  describe '#sku' do
    it { expect(subject).to respond_to :sku }
    it { expect(subject).to respond_to :sku= }
  end
  describe '#name' do
    it { expect(subject).to respond_to :name }
    it { expect(subject).to respond_to :name= }
  end
  describe '#price' do
    it { expect(subject).to respond_to :price }
    it { expect(subject).to respond_to :price= }
  end
  describe '#quantity' do
    it { expect(subject).to respond_to :quantity }
    it { expect(subject).to respond_to :quantity= }
  end

end

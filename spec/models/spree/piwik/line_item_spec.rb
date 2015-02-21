require 'spec_helper'

describe Spree::Piwik::LineItem, type: :model do
  describe '.from_product' do
    it 'instantiates self from a product' do
      product = double(:product, sku: 'sku', name: 'name', price: 'price')
      line_item = Spree::Piwik::LineItem.from_product(product)
      expect(line_item).to be_a_kind_of Spree::Piwik::LineItem
      expect(line_item.sku).to eq 'sku'
      expect(line_item.name).to eq 'name'
      expect(line_item.price).to eq 'price'
      expect(line_item.quantity).to be_nil
    end
  end

  describe '.from_line_item' do
    it 'instantiates self from a line_item' do
      spree_line_item = double(:spree_line_item, sku: 'sku', name: 'name', price: 'price', quantity: 1)
      line_item = Spree::Piwik::LineItem.from_spree_line_item(spree_line_item)
      expect(line_item).to be_a_kind_of Spree::Piwik::LineItem
      expect(line_item.sku).to eq 'sku'
      expect(line_item.name).to eq 'name'
      expect(line_item.price).to eq 'price'
      expect(line_item.quantity).to eq 1
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

require 'spec_helper'

describe Spree::BaseHelper, type: :helper do
  describe "#piwik_client" do
    it 'returns a PiwikClient' do
      expect(helper.piwik_client).to be_an_instance_of(Spree::Piwik::Client)
    end

    it 'memoizes the piwik_client' do
      expect(helper.piwik_client).to be helper.piwik_client
    end

    context 'when there is an @product' do
      before { @product = assign(:product, double(:product)) }
      it 'passes in @product' do
        expect(Spree::Piwik::Client).to receive(:new).with(hash_including(product: @product))
        helper.piwik_client
      end
    end

    context 'when there is no @product' do
      it 'passes in nil' do
        expect(helper.piwik_client.product).to be_nil
      end
    end

    context 'when there is an @order' do
      before { @order = assign(:order, double(:order)) }
      it 'passes in the order' do
        expect(Spree::Piwik::Client).to receive(:new).with(hash_including(order: @order))
        helper.piwik_client
      end
    end
  end
end

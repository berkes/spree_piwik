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
        expect(helper.piwik_client.product).to eq @product
      end
    end

    context 'when there is no @product' do
      it 'passes in nil' do
        expect(helper.piwik_client.product).to be_nil
      end
    end
  end
end

require 'spec_helper'

describe Spree::BaseHelper, type: :helper do
  describe "#piwik_client" do
    it 'returns a PiwikClient' do
      expect(helper.piwik_client).to be_an_instance_of(SpreePiwik::PiwikClient)
    end

    it 'memoizes the piwik_client' do
      expect(helper.piwik_client).to be helper.piwik_client
    end
  end
end

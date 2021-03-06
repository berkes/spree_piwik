require "spec_helper"

describe Spree::PiwikConfiguration do
  it 'has a default piwik_url example.com' do
    expect(Spree::Piwik::Config.preferred_piwik_url).to eq 'example.com'
  end

  it 'has a default piwik_id 0' do
    expect(Spree::Piwik::Config.preferred_piwik_id).to eq 0
  end
end

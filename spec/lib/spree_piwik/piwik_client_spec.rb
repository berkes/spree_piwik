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
end

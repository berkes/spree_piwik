require "spec_helper"

describe "deface override call" do
  subject { Deface::Override.find(virtual_path: "spree/layouts/spree_application").first }

  it "triggers on spree_application layout" do
    expect(subject.name).to eq "add_piwik_tracking_tag_to_layout"
  end

  it "inserts at the bottom of the body tag" do
    selector = %([data-hook='body'])
    expect(subject.selector).to eq selector
    expect(subject.args[:insert_bottom]).to eq selector
  end

  it "users spree/piwik partial" do
    expect(subject.source_argument).to eq :partial
    expect(subject.args[:partial]).to eq 'spree/piwik'
  end
end

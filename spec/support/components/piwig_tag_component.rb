class PiwikTagComponent
  extend Capybara::DSL
  include Capybara::DSL

  def in_html?
    return false if script_tag.empty?
    page.body.include?('<!-- Piwik -->') && page.body.include?('<!-- End Piwik Code -->')
  end

  def tracker_url_assigment
    script_tag.to_s.lines.find { |l| l.match(/var u=/) }.strip
  end

  def to_s
    script_tag.to_s
  end

  private

  def script_tag
    doc.xpath('//body/script')
  end

  def doc
    Nokogiri::HTML(page.body)
  end
end

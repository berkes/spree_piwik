Spree::BaseHelper.class_eval do
  def piwik_client
    @piwik_client ||= SpreePiwik::PiwikClient.new(product: @product)
  end
end

Spree::BaseHelper.class_eval do
  def piwik_client
    @piwik_client ||= Spree::Piwik::Client.new(product: @product)
  end
end

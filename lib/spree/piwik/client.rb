module Spree
  module Piwik
    class Client
      def initialize(attrs = {})
        @product = attrs[:product]
        @order   = attrs[:order]
      end

      def url
        Spree::Piwik::Config.preferred_piwik_url
      end

      def site_id
        Spree::Piwik::Config.preferred_piwik_id
      end

      def product
        @product
      end

      def order
        @order
      end

      def track_cart_update?
        !@order.nil? && @order.cart?
      end

      def categories
        taxons = @product.try(:taxons) || []

        taxons.map(&:name).first(5)
      end
    end
  end
end

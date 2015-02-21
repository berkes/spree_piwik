module Spree
  module Piwik
    class Client
      include ActiveModel::Model

      attr_accessor :product, :order

      def product
        Spree::Piwik::LineItem.from_product_ish(@product) if @product
      end

      def url
        Spree::Piwik::Config.preferred_piwik_url
      end

      def site_id
        Spree::Piwik::Config.preferred_piwik_id
      end

      def ecommerce_item
        LineItem.from_product_ish(@order.line_items.first)
      end

      def track_cart_update?
        !@order.nil? && @order.cart?
      end
    end
  end
end

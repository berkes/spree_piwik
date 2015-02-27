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

      def ecommerce_items
        @order.line_items.map do |li|
          Spree::Piwik::LineItem.from_product_ish(li)
        end
      end

      def track_cart_update?
        order? && @order.cart?
      end

      def track_ecommerce_order?
        order? && @order.complete?
      end

      private
      def order?
        !@order.nil?
      end
    end
  end
end

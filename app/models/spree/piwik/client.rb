module Spree
  module Piwik
    class Client
      include ActiveModel::Model

      attr_accessor :product, :order

      def product
        LineItem.from_product(@product) if @product
      end

      def url
        Spree::Piwik::Config.preferred_piwik_url
      end

      def site_id
        Spree::Piwik::Config.preferred_piwik_id
      end

      def ecommerce_item
        LineItem.from_spree_line_item(@order.line_items.first)
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

module Spree
  module Piwik
    class LineItem
      include ActiveModel::Model

      attr_accessor :sku, :name, :price, :quantity

      def self.from_product(product)
        new(sku: product.sku, name: product.name, price: product.price)
      end

      def self.from_spree_line_item(spree_line_item)
        new(sku: spree_line_item.sku, name: spree_line_item.name, price: spree_line_item.price, quantity: spree_line_item.quantity)
      end

    end
  end
end

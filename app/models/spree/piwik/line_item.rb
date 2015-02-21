module Spree
  module Piwik
    class LineItem
      include ActiveModel::Model

      attr_accessor :sku, :name, :price, :quantity, :categories

      def self.from_product(product)
        new(sku: product.sku, name: product.name, price: product.price, categories: product.taxons)
      end

      def self.from_spree_line_item(spree_line_item)
        new(sku: spree_line_item.sku, name: spree_line_item.name, price: spree_line_item.price, quantity: spree_line_item.quantity)
      end

      def categories
        defaulted_categories = @categories || []
        defaulted_categories.map(&:name).first(5)
      end
    end
  end
end

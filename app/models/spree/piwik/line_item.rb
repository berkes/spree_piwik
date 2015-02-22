module Spree
  module Piwik
    class LineItem
      include ActiveModel::Model

      ATTRIBUTES = [:sku, :name, :price, :quantity, :categories]
      attr_accessor(*ATTRIBUTES)

      ##
      # Create a LineItem from a Spree::LinteItem-ish thing (line_items,
      # products, variants)
      #
      # All attributes in ATTRIBUTES will be mapped:
      #
      # When we add a (private) method with the name
      # map_product_ish_sku, this method will be called and get the
      # product_ish to generate a value for that attribute.
      #
      # When the product_ish has the same attribute name and no
      # mapping-method provided the value, it will simply use the value
      # from that attribute on product_ish
      def self.from_product_ish(product_ish)
        values = ATTRIBUTES.map { |a| [a, product_ish_attr(a, product_ish)] }
        new(Hash[values])
      end

      # Private
      def self.product_ish_attr(attr_name, product_ish)
        mapping_method = "map_product_ish_#{attr_name}".to_sym
        self.respond_to?(mapping_method) ? send(mapping_method, product_ish) : product_ish.try(attr_name)
      end

      # Private
      def self.map_product_ish_categories(product_ish)
        defaulted_taxons = product_ish.try(:taxons) || []
        defaulted_taxons.map(&:name).first(5)
      end
    end
  end
end

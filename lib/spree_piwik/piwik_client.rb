module SpreePiwik
  class PiwikClient
    def initialize(attrs = {})
      @product = attrs[:product]
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

    def categories
      taxons = @product.try(:taxons) || []

      taxons.map(&:name).first(5)
    end
  end
end

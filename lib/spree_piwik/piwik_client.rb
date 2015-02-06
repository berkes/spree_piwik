module SpreePiwik
  class PiwikClient
    def url
      Spree::Config.preferred_piwik_url
    end

    def site_id
      Spree::Config.preferred_piwik_id
    end
  end
end

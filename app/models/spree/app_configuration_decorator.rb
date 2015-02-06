Spree::AppConfiguration.class_eval do
  preference :piwik_url, :string, :default => "example.com"
  preference :piwik_id,  :integer, :default => 0
end

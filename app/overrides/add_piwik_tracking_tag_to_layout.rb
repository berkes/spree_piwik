Deface::Override.new(
  :virtual_path => 'spree/layouts/spree_application',
  :name => 'add_piwik_tracking_tag_go_layout',
  :insert_bottom => "[data-hook='body']",
  :text => "<!-- Piwik -->")

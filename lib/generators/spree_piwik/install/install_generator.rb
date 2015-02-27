# Must be named SpreePiwik because dummygenerator expects it
module SpreePiwik
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("../../../templates", __FILE__)

      class_option :auto_run_migrations, :type => :boolean, :default => false

      def copy_initializer
        template "spree_piwik.rb", "config/initializers/spree_piwik.rb"
      end

      def add_javascripts
        append_file 'vendor/assets/javascripts/spree/frontend/all.js', "//= require spree/frontend/spree_piwik\n"
        append_file 'vendor/assets/javascripts/spree/backend/all.js', "//= require spree/backend/spree_piwik\n"
      end

      def add_stylesheets
        inject_into_file 'vendor/assets/stylesheets/spree/frontend/all.css', " *= require spree/frontend/spree_piwik\n", :before => /\*\//, :verbose => true
        inject_into_file 'vendor/assets/stylesheets/spree/backend/all.css', " *= require spree/backend/spree_piwik\n", :before => /\*\//, :verbose => true
      end

    end
  end
end

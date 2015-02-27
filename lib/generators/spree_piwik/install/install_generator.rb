# Must be named SpreePiwik because dummygenerator expects it
module SpreePiwik
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("../../../templates", __FILE__)

      class_option :auto_run_migrations, :type => :boolean, :default => false

      def copy_initializer
        template "spree_piwik.rb", "config/initializers/spree_piwik.rb"
      end
    end
  end
end

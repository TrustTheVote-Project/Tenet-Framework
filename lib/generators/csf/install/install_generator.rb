module Csf
  class InstallGenerator < ::Rails::Generators::Base
    source_root File.expand_path('../templates', __FILE__)

    def copy_csf_config
      copy_file "csf_config.yml", "config/csf_config.yml"
      copy_file "csf_config.rb", "config/initializers/csf_config.rb"
    end

    def copy_csf_migrations
      rake "csf:install:migrations"
    end

    def add_routes
      route 'mount Csf::Engine => "/"'
    end
  end
end

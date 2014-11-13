module Tenet
  class InstallGenerator < ::Rails::Generators::Base
    source_root File.expand_path('../templates', __FILE__)

    def copy_tenet_config
      copy_file "tenet_config.yml", "config/tenet_config.yml"
    end

    def copy_tenet_migrations
      rake "tenet_engine:install:migrations"
    end

    def add_landing_page_route
      route 'root "tenet/pages#landing"'
    end

    def configure_sidekiq
      copy_file "sidekiq.rb", "config/initializers/sidekiq.rb"
    end

    def copy_otp_scripts
      directory "scripts"
      chmod "scripts/otp-generate", 0755
      chmod "scripts/otp-keys", 0755
    end
  end
end

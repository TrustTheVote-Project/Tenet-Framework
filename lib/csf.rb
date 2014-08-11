require "csf/engine"
require "haml"
require "bootstrap-sass"
require "gon"
require "jquery-rails"
require "carmen-rails"
require "sidekiq"
require "sorcery"

module Csf

  class Engine < ::Rails::Engine
    config.generators do |g|
      g.test_framework      :rspec,        :fixture => false
      g.fixture_replacement :factory_girl, :dir => 'spec/factories'
      g.assets false
      g.helper false
    end
  end

end

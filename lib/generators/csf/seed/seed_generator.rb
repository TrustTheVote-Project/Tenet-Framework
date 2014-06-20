module Csf
  class SeedGenerator < ::Rails::Generators::Base

    TYPES = [ 'state', 'outlying area' ]

    source_root File.expand_path('../templates', __FILE__)

    def seed_states
      return if State.count > 0

      require 'carmen'

      us = Carmen::Country.named('United States')
      us.subregions.each do |s|
        next unless TYPES.include?(s.type)

        State.create(code: s.code, name: s.name)
      end
    end

  end
end

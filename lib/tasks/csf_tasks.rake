namespace :csf do
  namespace :db do
    desc "Seeds database with data"
    task :seed do
      return if State.count > 0

      require 'carmen'
      supported_types = [ 'state', 'outlying area' ]

      us = Carmen::Country.named('United States')
      us.subregions.each do |s|
        next unless supported_types.include?(s.type)
        State.create(code: s.code, name: s.name)
      end
    end
  end
end

namespace :csf do
  namespace :db do
    desc "Seeds database with data"
    task :seed do
      supported_types = [ 'state', 'outlying area' ]

      us = Carmen::Country.named('United States')
      us.subregions.each do |s|
        next unless supported_types.include?(s.type)
        State.create_with(name: s.name).find_or_create_by(code: s.code)
      end

      State.create_with(name: '-- Other --').find_or_create_by(code: 'ZZ')
    end
  end
end

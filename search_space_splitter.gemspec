Gem::Specification.new do |s|
  s.name        = 'search_space_splitter'
  s.version     = '1.0.0'
  s.summary     = 'Search Space Splitter'
  s.description = 'Splits a search space into n sections.'
  s.author      = 'Christopher Patuzzo'
  s.email       = 'chris@patuzzo.co.uk'
  s.files       = ['README.md'] + Dir['lib/**/*.*']
  s.homepage    = 'https://github.com/cpatuzzo/search_space_splitter'

  s.add_dependency 'range_splitter'
  s.add_development_dependency 'rspec'
end

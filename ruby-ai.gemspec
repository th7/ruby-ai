Gem::Specification.new do |s|
  s.name = 'ruby-ai'
  s.version = '0.0.3'
  s.executables << 'ruby-ai'
  s.date = '2013-09-24'
  s.summary = 'ruby-ai'
  s.description = 'Write AI code for this simple game.'
  s.authors = ['Tyler Hartland']
  s.email = 'tylerhartland7@gmail.com'
  s.files = `git ls-files`.split("\n")
  s.homepage = 'http://rubygems.org/gems/ruby-ai'
  s.license = 'MIT'
  s.add_runtime_dependency 'gosu', ['~> 0.7']
  s.add_runtime_dependency 'texplay', ['~> 0.4']
end

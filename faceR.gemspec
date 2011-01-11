spec = Gem::Specification.new do |s|
  s.name = 'facer'
  s.version = '0.0.4'
  s.summary = "Wrapper for face.com API."
  s.description = %{Simple wrapper for face.com api.}
  s.files = Dir['lib/**/*.rb'] + ["init.rb", "Manifest.txt","Gemfile","README"]
  s.test_files = Dir['test/**/*.rb'] 
  s.require_path = 'lib'
  s.requirements << 'The gem uses multipart-post, mime-types and JSON gem'
  s.has_rdoc = true
  s.extra_rdoc_files = Dir['[A-Z]*']
  s.rdoc_options << '--title' <<  'Facer'
  s.author = "Stefano Valicchia"
  s.email = "stefano.valicchia@gmail.com"
  s.add_dependency('multipart-post','>= 1.0.1')
  s.add_dependency('json','>= 1.4.6')
  s.add_dependency('mime-types','>= 1.16')
end
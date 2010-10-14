specifications = Gem::Specification.new do |spec| 
  spec.name = "rails_zombie"
  spec.version = "1.0.0"
  spec.author = "Philippe Cantin"
  spec.homepage = "http://github.com/anoiaque/rails_zombie"
  spec.platform = Gem::Platform::RUBY
  spec.summary = "Auto Get controller (nested) instances variables from (nested) id "
  spec.description = "Auto Get controller (nested) instances variables from (nested) id"
  spec.files = Dir['lib/**/*.rb']
  spec.require_path = "lib"
  spec.test_files  = Dir['test/**/*.rb']
  spec.has_rdoc = false
  spec.extra_rdoc_files = ["README.rdoc"]
end
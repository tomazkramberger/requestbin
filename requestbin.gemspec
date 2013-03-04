# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |gem|
  gem.name          = "requestbin"
  gem.version       = "0.0.1"
  gem.authors       = ["Geoffroy Lorieux"]
  gem.email         = ["lorieux.g@gmail.com"]
  gem.description   = %q{This gem is a simple wrapper of the requestb.in website API. For more info on the API please go to http://requestb.in/docs/API}
  gem.summary       = %q{This gem is a simple wrapper of the requestb.in website API.}
  gem.homepage      = "http://requestb.in/"
  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end

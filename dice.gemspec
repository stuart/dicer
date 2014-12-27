# -*- encoding: utf-8 -*-
require File.expand_path('../lib/dice/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Stuart Coyle"]
  gem.email         = ["stuart.coyle@gmail.com"]
  gem.description   = %q{A parser for dice notation. Rolls dice and does various arithmetic.}
  gem.summary       = %q{Dice notation parser}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "dice_parser"
  gem.require_paths = ["lib"]
  gem.version       = Dice::VERSION
  gem.requirements  << 'Treetop version 1.4 or later.'
  gem.add_dependency "treetop"
end

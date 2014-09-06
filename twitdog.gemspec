# -*- encoding: utf-8 -*-
require File.expand_path('../lib/twitdog/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Misty De Meo"]
  gem.email         = ["mistydemeo@gmail.com"]
  gem.description   = <<-EOS
                      Twitdog is a small API client for Twitpic.
                      It was created to assist downloading Twitpic
                      image galleries before Twitpic's shutdown.
                      EOS
  gem.summary       = %q{Miniature Twitpic API client}
  gem.homepage      = "https://github.com/mistydemeo/twitdog"

  gem.files         = `git ls-files`.split($\)
  gem.bindir        = "bin"
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "twitdog"
  gem.require_paths = ["lib"]
  gem.version       = Twitdog::VERSION

  gem.add_dependency 'slop', '>= 3.6.0'

  gem.add_development_dependency 'rake', '>= 0.9.2.2'
  gem.add_development_dependency 'bundler'
end

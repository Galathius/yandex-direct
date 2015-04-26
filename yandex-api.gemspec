# -*- encoding: utf-8 -*-
require File.expand_path('../lib/yandex_direct/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ['Ilya Kamenko']
  gem.email         = ['ilya.kamenko@gmail.com']
  gem.description   = %q{Yandex.Direct integration}
  gem.summary       = %q{Yandex.Direct integration}
  gem.homepage      = 'https://github.com/galathius/yandex_direct'

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = 'yandex_direct'
  gem.require_paths = ['lib']
  gem.version       = YandexDirect::API::VERSION

  gem.add_development_dependency 'bundler', '~> 1.7'
  gem.add_development_dependency 'rake', '~> 10.0'
  gem.add_development_dependency 'rspec'
end

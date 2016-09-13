lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'steam_deals/version'

Gem::Specification.new do |spec|
  spec.authors       = ["Justin Thomas"]
  spec.email         = ["jvthomas0209@gmail.com"]
  spec.description   = "Scrape steamdb.info for latest steam deals. Provides name, sale price, sale discount, and misc. details"
  spec.summary       = "Scrapes steamdb.info for latest deals"
  spec.homepage      = "https://github.com/JVThomas/steam-deals-parser"
  spec.licenses      = ['MIT']
  spec.files         = `git ls-files`.split($\)
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.executables   = ["steam-deals"]
  spec.name          = "steamdeals-cli-gem"
  spec.require_paths = ["lib", "lib/steam_deals"]
  spec.version       = SteamDeals::VERSION

  spec.add_dependency "nokogiri", '~> 1.6.8', ">= 1.6.8"
  spec.add_development_dependency "bundler", "~> 1.10", ">= 1.10"
  spec.add_development_dependency "rake", "~> 10.0", ">= 10.0"
  spec.add_development_dependency "rspec",  '~> 3.4.0', ">= 3.4.0"
  spec.add_development_dependency "pry",  '~> 0.10.3', ">= 0.10.3"
  spec.add_development_dependency "vcr"
  spec.add_development_dependency "webmock"
end

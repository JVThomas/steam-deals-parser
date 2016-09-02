lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'steam_deals/version'

Gem::Specification.new do |spec|
  spec.authors       = ["Justin Thomas"]
  spec.email         = ["jvthomas0209@gmail.com"]
  spec.description   = "Scrape steamdb.info for daily steam deals, provides name, sale price, sale discount, and minor descriptions"
  spec.summary       = "Scrapes steamdb.info for daily and weeklong deals"
  spec.licenses      = ['MIT']
  spec.files         = ["lib/steam_deals.rb","lib/steam_deals/version.rb", "lib/steam_deals/deal.rb", "lib/steam_deals/cli.rb"]
  spec.executables   = ["steam-deals"]
  spec.name          = "steamdeals-cli-gem"
  spec.require_paths = ["lib", "lib/steam_deals"]
  spec.version       = SteamDeals::VERSION

  spec.add_development_dependency "bundler", "~> 1.10", ">= 1.10"
  spec.add_development_dependency "rake", "~> 10.0", ">= 10.0"
  spec.add_development_dependency "rspec",  '~> 3.4.0', ">= 3.4.0"
  spec.add_development_dependency "nokogiri", '~> 1.6.8', ">= 1.6.8"
  spec.add_development_dependency "pry",  '~> 0.10.3', ">= 0.10.3"
end

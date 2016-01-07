lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'steam_deals/version'

Gem::Specification.new do |spec|
  spec.authors       = ["Justin Thomas"]
  spec.email         = ["jvthomas0209@gmail.com"]
  spec.description   = "Scrape steamdb.info for daily steam deals"
  spec.summary       = "Scrape steamdb.info for daily steam deals"

  spec.files         = ["lib/steam_deals.rb","lib/steam_deals/version.rb", "lib/steam_deals/deal.rb", "lib/steam_deals/cli.rb"]
  spec.executables   = ["steam-deals"]
  #spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.name          = "steamdeals-cli-gem"
  spec.require_paths = ["lib", "lib/steam_deals"]
  spec.version       = SteamDeals::VERSION

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "nokogiri"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "open-uri"
end

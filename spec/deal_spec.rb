require 'spec_helper'

describe 'SteamDeal::Deal' do
  it 'is defined' do
    expect(SteamDeals::Deal).to be_a(Class)
  end

  describe '.scrape_sections' do
    around(:each) do |example|
      VCR.use_cassette("scrape_deals_list") do
        example.run
      end
    end
    it 'scrapes the various sales categories' do
      SteamDeals::Deal.scrape_sections
      expect(SteamDeals::Deal.sections).to_not be_empty
    end
  end
end
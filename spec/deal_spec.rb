describe 'SteamDeal::Deal' do
  it 'is defined' do
    expect(SteamDeals::Deal).to be_a(Class)
  end

  describe '.scrape_deals_list' do
    around(:each) do |example|
      VCR.use_cassette("scrape_deals_list") do
        example.run
      end
    end
    it 'scrapes deals and creates instances' do
      SteamDeals::Deal.scrape_deals_list

      expect(SteamDeals::Deal.all).to_not be_empty
    end
  end
end
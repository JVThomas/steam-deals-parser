class SteamDeals::Deal
  
  @@all = []
  
  attr_accessor :name, :discount, :price, :details_url, :app_type, :developer, :publisher, :supported_os, :app_desc 

  def initialize(name = "", url = "", discount = "", price = "")
    @name = name
    @details_url = url
    @discount = discount
    @price = price
    @developer = "N/A"
    @publisher = "N/A"
    @supported_os = "N/A"
    @app_desc = "N/A"
    scrape_add_details
  end

  def self.scrape_deals_list #only scrapes daily deal for now
    @@all.clear
    doc = Nokogiri::HTML(open("https://steamdb.info/sales/"))
    app_list = doc.css("#sales-section-dailydeal .table-sales .appimg")
    app_list.each do |app|
      app_name = app.css("a.b")[0].text
      app_url ="https://steamdb.info/#{app.css("a.b")[0]["href"]}"
      discount = app.css(".price-discount i").text
      price = "#{app.css("td")[4].text}"
      game = SteamDeals::Deal.new(app_name,app_url,discount,price)
      @@all << game
    end
    self.all
  end

  def self.all
    @@all
  end

  def self.app_at(num)
    @@all[num-1]
  end

  def scrape_add_details
    doc = Nokogiri::HTML(open(@details_url))
    @app_desc = doc.css(".span4 p.header-description").text
    app_details = doc.css(".table-dark tr")
    if app_details[0].css("td")[0].text == "App ID"
      @app_type = app_details[1].css("td")[1].text 
      @developer = app_details[3].css("td")[1].text 
      @publisher = app_details[4].css("td")[1].text
      @supported_os = app_details.css(".icon").collect{|element| element["aria-label"]}.join(", ")
    end
  end 
end
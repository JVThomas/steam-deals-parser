class SteamDeals::Deal
  
  @@apps = []
  @@sections = []
  
  attr_accessor :name, :discount, :price, :details_url, :app_type, :developer, :publisher, :supported_os, :app_desc, :highest_discount 

  def initialize(name = "", url = "", discount = "", price = "", highest_discount = "")
    @name = name
    @details_url = url
    @discount = discount
    @highest_discount = highest_discount
    @price = price
    @developer = "N/A"
    @publisher = "N/A"
    @supported_os = "N/A"
    @app_desc = "N/A"
  end

  def self.scrape_sections
    @@sections.clear
    doc = Nokogiri::HTML(open("https://steamdb.info/sales/"))
    section_css = doc.css(".sales-section")
    while section_css.length > 0
      target_section = section_css.shift
      section_name = target_section.css(".pre-table-title a").text
      @@sections << {name: section_name, css: target_section}
    end
    self.sections
  end

  #removal later
  def self.scrape_weeklong_deals
    @@apps.clear
    doc = Nokogiri::HTML(open("https://steamdb.info/sales/"))
    app_list = doc.css("#sales-section-weeklong-deals .table-sales .appimg")
    scrape_initial_details(app_list)
    self.apps
  end

  #removal later
  def self.scrape_daily_deals 
    @@all.clear
    doc = Nokogiri::HTML(open("https://steamdb.info/sales/"))
    app_list = doc.css("#sales-section-daily-deal .table-sales .appimg")
    scrape_initial_details(app_list)
    self.apps
  end

  def self.apps
    @@apps
  end

  def self.sections
    @@sections
  end

  def self.section_at(num)
    @@sections[num-1]
  end

  def self.app_at(num)
    @@apps[num-1]
  end

  def self.scrape_section_apps(section)
    @@apps.clear
    app_list = section[:css].css(".table-sales .appimg")
    scrape_initial_details(app_list)
  end


  def self.scrape_initial_details(app_list)
    app_list.each do |app|
      app_name = app.css("a.b")[0].text
      app_url ="https://steamdb.info/#{app.css("a.b")[0]["href"]}"
      discount = app.css("td")[3].text
      highest_discount = app.css("td")[2].css(".highest-discount").text
      price = "#{app.css("td")[4].text}"
      game = SteamDeals::Deal.new(app_name, app_url, discount,  price, highest_discount)
      @@apps << game
    end
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
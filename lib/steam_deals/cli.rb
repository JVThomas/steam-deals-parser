class SteamDeals::CLI
  
  def start
    input = ""
    while input != "exit"
      puts "Here are the apps listed for today's Steam Daily Deals"
      puts "-------------------------------------------------------"
      SteamDeals::Deal.scrape_deals_list
      SteamDeals::Deal.all.each.with_index(1) do |app, index|
        puts "#{index}. #{app.name}"
      end
      puts " "
    
      puts "Which game would you like to see in detail? (Enter the number associtaed with game on list)"
      puts "or you can enter 'exit' to exit out of the program"
      input = gets.chomp

      if input.downcase == "exit"
        puts "\nGoodbye!"
      elsif input.to_i > 0 && game = SteamDeals::Deal.app_at(input.to_i)        
        display_details(game)
      else
        puts "\nInvalid input. Try again.\n" 
      end
    end
  end

  def display_details(game)
    input = ""
    while input.downcase != "exit"
      puts ""
      puts "What details would you like to see? (Enter number choice or type exit to return to previous menu"
      puts ""
      puts "1. Sale Details"
      puts "2. Game Details"
      puts ""
      
      input = gets.chomp
      case input
      when "1"
        show_sale_details(game)
      when "2"
        show_app_details(game)
      when "exit"
        puts "\nReturning to menu\n"
      else
        puts "\nInvalid input. Try again.\n"
      end
    
    end
  end

  def show_sale_details(game)
    puts ""
    puts "Here are the sale details"
    puts "-------------------------"
    puts "Name : #{game.name}"
    puts "Discount : #{game.discount}"
    puts "Sale Price : #{game.price}"
    puts "--------------------------"
    puts ""
  end

  def show_app_details(game)
    puts ""
    puts "Here are the app details"
    puts "------------------------"
    puts "Name : #{game.name}"
    puts "App Type : #{game.app_type}"
    puts "Developer : #{game.developer}"
    puts "Publisher : #{game.publisher}"
    puts "Supported Systems: #{game.supported_os}"
    puts ""
    puts "Description"
    puts "--------------------------------------------------"
    puts "#{game.app_desc}"
    puts "---------------------------------------------------"
    puts ""
  end
end
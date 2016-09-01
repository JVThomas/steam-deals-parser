class SteamDeals::CLI
  
  def start
    input = ""
    while input != "exit"
      puts "\nWhich Sale would you like to see?"
      puts "---------------------------------"
      puts "1. Daily Deals\n"
      puts "2. Weeklong Deals" 
      puts "(Or type 'exit' to end program)\n"
      input = gets.strip.downcase
      case input
      when "1"
        display_daily_deals
      when "2"
        display_weeklong_deals
      when "exit"
        puts "\nGoodbye!"
      else
        puts "\nInvalid input, try again!\n"
      end
    end
  end

  def display_daily_deals
    puts "\nNow retreiving Daily Deals. Please be patient\n"
    puts "\nHere are the apps listed for today's Steam Daily Deals"
    puts "-------------------------------------------------------"
    SteamDeals::Deal.scrape_daily_deals
    SteamDeals::Deal.all.each.with_index(1) do |app, index|
      puts "#{index}. #{app.name}"
    end
    puts " "
    show_game_list
  end

  def display_weeklong_deals
    puts "\nNow retreiving Weeklong Deals. Please be patient\n"
    SteamDeals::Deal.scrape_weeklong_deals
    puts "Here are the apps listed for today's Steam Weeklong Deals"
    puts "-------------------------------------------------------"
    SteamDeals::Deal.all.each.with_index(1) do |app,index|
      puts "#{index}. #{app.name}"
    end
    puts " "
    show_game_list
  end

  def display_details(game)
    input = ""
    while input != "exit"
      puts ""
      puts "What details would you like to see? (Enter number choice or type exit to return to previous menu)"
      puts ""
      puts "1. Sale Details"
      puts "2. Game Details"
      puts ""
      
      input = gets.chomp.downcase
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
    puts "Loading sale details...\n\n"
    puts "Here are the sale details"
    puts "-------------------------"
    puts "Name : #{game.name}"
    puts "Discount : #{game.discount}"
    puts "Sale Price : #{game.price}"
    puts "--------------------------"
    puts ""
  end

  def show_app_details(game)
    puts "Loading Game Details...\n\n"
    game.scrape_add_details
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

  def show_game_list
    input = ""
    while input != "exit"
      puts "Which game would you like to see in detail? (Enter the number associtaed with game on list)"
      puts "or you can enter 'exit' to return to previous menu"
      input = gets.chomp.downcase

      if input.downcase == "exit"
        puts "\nReturning to previous menu\n"
      elsif input.to_i > 0 && game = SteamDeals::Deal.app_at(input.to_i)        
        display_details(game)
      else
        puts "\nInvalid input. Try again.\n" 
      end
    end
  end

end
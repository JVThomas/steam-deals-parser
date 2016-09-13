class SteamDeals::CLI
  
  def start
    clear_terminal
    input = ""
    SteamDeals::Deal.scrape_sections
    sections_length = SteamDeals::Deal.sections.length
    while input != "exit"
      puts "\nWhich Sale would you like to see?"
      puts "---------------------------------"
      SteamDeals::Deal.sections.each_with_index do |section, index|
        puts "#{index+1}. #{section[:name]}\n"
      end
      puts "(Or type 'exit' to end program)\n"
      
      input = gets.strip.downcase
      
      if input == "exit"
        puts "\nGoodbye!"
      elsif input.scan("/\D+/").length > 0
        clear_terminal
        puts "Invalid input. Please try again\n"
      elsif input.to_i > sections_length || input.to_i < 1
        clear_terminal
        puts "Number out of range. Please try again\n"
      else
        display_section_deals(SteamDeals::Deal.section_at(input.to_i))
      end
    end
  end

  def display_section_deals(section)
    clear_terminal
    puts "Now retrieving #{section[:name]}. Please be patient."
    SteamDeals::Deal.scrape_section_apps(section)
    puts "\nHere are the apps listed for today's #{section[:name]}"
    show_game_list
  end

  def display_details(game)
    clear_terminal
    input = ""
    while input != "exit"
      puts ""
      puts "What details would you like to see about #{game.name}? (Enter number choice or type exit to return to previous menu)"
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
        clear_terminal
      else
        puts "\nInvalid input. Try again.\n"
      end
    end
  end

  def show_sale_details(game)
    clear_terminal
    puts "Loading sale details...\n\n"
    puts "Here are the sale details"
    puts "-------------------------"
    puts "Name : #{game.name}"
    puts "Discount : #{game.discount}, #{game.highest_discount}"
    puts "Sale Price : #{game.price}"
    puts "--------------------------"
    puts ""
  end

  def show_app_details(game)
    clear_terminal
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
    clear_terminal
    input = ""
    while input != "exit"
      puts "Here are the apps..."
      puts "---------------------------------------------------"
      SteamDeals::Deal.apps.each.with_index(1) do |app, index|
        puts "#{index}. #{app.name}"
      end
      puts " "
      puts "Which game would you like to see in detail? (Enter the number associtaed with game on list)"
      puts "or you can enter 'exit' to return to previous menu"
      input = gets.chomp.downcase

      if input.downcase == "exit"
        clear_terminal
        puts "\nReturning to previous menu\n"
      elsif input.to_i > 0 && game = SteamDeals::Deal.app_at(input.to_i)        
        display_details(game)
      else
        clear_terminal
        puts "\nInvalid input. Try again.\n"
        puts "Reloading..."
        sleep(1) 
      end
    end
  end

  def clear_terminal
    puts "\e[H\e[2J"
  end

end
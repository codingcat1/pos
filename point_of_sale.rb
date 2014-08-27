require 'active_record'
require './lib/cashier'
require './lib/customer'
require './lib/product'
require 'yaml'

database_configurations = YAML::load(File.open('./db/config.yml'))
development_configuration = database_configurations['development']
ActiveRecord::Base.establish_connection(development_configuration)


def welcome
  system 'clear'
  puts "*** WELCOME TO POS! ***"
  menu
end

def menu
  choice = nil
  until choice == 'x'
    puts "Type '1' to access the product menu."
    puts "Type '2' to access the cashier menu."
    puts "Type '3' to access the transaction menu."
    puts "Type 'x' to exit the program."
    choice = gets.chomp
    case choice
    when '1'
      product_menu
    when '2'
      cashier_menu
    when '3'
      transaction_menu
    when 'x'
      puts "Good-bye!"
      sleep(1)
      system 'clear'
    else
      puts "Sorry, that wasn't a valid option."
    end
  end
end

def product_menu
  puts "*** PRODUCT MENU ***\n"
  puts "Type 'a' to add a new product and price."
  puts "Type 'l' to list all products."
  puts "Type 'x' to return to the main menu."
  choice = gets.chomp
  case choice
  when 'a'
    add_products
  when 'l'
    list_products
  when 'x'
    puts "back to main menu"
  else
    puts "Sorry, that wasn't a valid option."
  end
end

def add_products
  puts "*** ADD A PRODUCT ***\n"
  puts "What is the name of the PRODUCT you would like to add?\n"
  product_name = gets.chomp
  new_product = Product.new({:name => product_name})
  new_product.save
  puts "What is the cost of '#{product_name}'?"
  puts "Ex: 3.99"
  product_price = gets.chomp
  new_price = Product.new({:price => product_price})
  new_price.save
  puts "#{product_name}-$#{product_price} has been added to your list of Products.\n\n"
  product_menu
end

welcome

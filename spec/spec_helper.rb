
require 'active_record'
require 'rspec'
require 'shoulda-matchers'
require 'cashier'
require 'customer'
require 'product'

ActiveRecord::Base.establish_connection(YAML::load(File.open('./db/config.yml'))["test"])

RSpec.configure do |config|
  config.after(:each) do
    Cashier.all.each { |cashier| cashier.destroy }
    Product.all.each { |product| product.destroy }
    Customer.all.each { |customer| customer.destroy }
  end
end

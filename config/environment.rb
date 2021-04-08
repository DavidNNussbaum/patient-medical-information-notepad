ENV['SINATRA_ENV'] ||= "development"

require 'bundler/setup'
Bundler.require(:default, ENV['SINATRA_ENV'])

ActiveRecord::Base.establish_connection(
  :adapter => "sqlite3",
  :database => "db/#{ENV['SINATRA_ENV']}.sqlite"
)

configure :development do
  set :database, "sqlite3:db/#{ENV['SINATRA_ENV']}.db"
end

require './app/controllers/application_controller'
require_all 'app'
require 'dotenv/load'
 

# <h1 class='text-center'><span class="border border-3">Welcome To Your Medical Information Notepad</span></h1>


# Create .env contains SESSION_SECRET=
# Add to Gemfile: gem 'dotenv'
# Create .gitignore contains .env
# In IRB enter: ruby -e "require 'securerandom'; puts SecureRandom.hex(20)"  
# [IF securerandom COMES OUT AS TRUE CAN DO JUS WORDS AFTER PUTS]
# THEN THE NUMBER THAT COMES OUT IS COPIED WITHOUT QUOTATIONS TO AFTER SESSION_SECRET=
# flash[:error] = "Invalid login credentials." In Gemfile must have gem 'sinatra-flash'
# and in application_controller must add:    register Sinatra::Flash



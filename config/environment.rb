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
# require './public/stylesheets/main"'
# <link rel="stylesheet" href="./public/stylesheets/main"> 
# <link rel="stylesheet" href="./public/stylesheets/main"> 
# <a href="https://www.google.com">Google</a> 
# <img src="https://i.imgur.com/H1qsYEl.png" alt="comedic crow gets wholesome support"> 
 

require 'bundler'

Bundler.require


# # conn = PG::Connection.new
# # binding.pry
#
# ActiveRecord::Base.establish_connection(
#  adapter:  "postgresql",
#  host:     "localhost",
#  username: "garry.clerge",
#  password: "",
#  database: "postgres"
# )
#
# # ActiveRecord::Base.establish_connection(ENV["DATABASE_URL"])
# # ActiveRecord::Base.establish_connection(adapter: 'postgresql', database: 'db/development.db')
ActiveRecord::Base.logger = false
require_all 'lib'
require_all 'app'

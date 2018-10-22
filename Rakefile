require 'require_all'
require 'pry'
require 'sinatra/activerecord'
require "sinatra/activerecord/rake"

require_all 'lib'
require_all 'models'

ActiveRecord::Base.logger = false

desc 'starts a console'
  task :console do
   Pry.start
  end

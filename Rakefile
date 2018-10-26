require 'require_all'
require 'pry'
require 'sinatra/activerecord'
require "sinatra/activerecord/rake"

require_all 'lib'
require_all 'app/models'

ActiveRecord::Base.logger = false

begin
  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new(:spec)
  task default: :spec
rescue LoadError
  # rspec not availible
end

desc 'starts a console'
  task :console do
   Pry.start
  end

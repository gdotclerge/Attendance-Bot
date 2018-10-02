require 'bundler'
Bundler.require


ActiveRecord::Base.logger = false
require_all 'lib'
require_all 'app'

class User < ActiveRecord::Base
  belongs_to :mod
  belongs_to :sheet
  
end

class User < ActiveRecord::Base
  belongs_to :cohorts
  belongs_to :sheet

end

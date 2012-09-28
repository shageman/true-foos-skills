class Player < ActiveRecord::Base
  attr_accessible :deviation, :mean, :name
  attr_accessor :rating
end

class Player < ActiveRecord::Base
  attr_accessible :deviation, :mean, :name
  attr_accessor :rating

  validates :name, :length => { :minimum => 3, :maximum => 20 }
  validates_uniqueness_of :name

  def self.order_by_ranking
    order("(mean - deviation) DESC")
  end

  def underscored_name
    "#{name.gsub(" ", "_")}"
  end
end

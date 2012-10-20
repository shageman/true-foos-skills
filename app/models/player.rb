class Player < ActiveRecord::Base
  attr_accessible :deviation, :mean, :name
  attr_accessor :rating

  validates :name, :length => { :minimum => 3, :maximum => 20 }
  validates_uniqueness_of :name

  def self.ranked_players
    where("deviation < 250").order("(mean - deviation) DESC")
  end

  def self.unranked_players
    where("deviation >= 250").order("(mean - deviation) DESC")
  end

  def underscored_name
    "#{name.gsub(" ", "_")}"
  end
end

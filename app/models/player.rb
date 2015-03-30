class Player
  # {"id"=>5, "nickname"=>"GM"}
  attr_accessor :id, :nickname, :rating

  def initialize(json)
    @id = json["id"]
    @nickname = json["nickname"]
    @rating = Saulabs::TrueSkill::Rating.new(1500.0, 1000.0, 1.0)
  end

  def mean
    rating.mean
  end

  def deviation
    rating.deviation
  end

  def underscored_name
    "#{nickname.gsub(/\s/, "_")}"
  end
end

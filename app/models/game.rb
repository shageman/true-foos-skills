class Game < ActiveRecord::Base
  attr_accessible :black_front_player_id, :black_back_player_id, :result, :yellow_front_player_id, :yellow_back_player_id, :goals_yellow, :goals_black

  belongs_to :black_front_player, foreign_key: :black_front_player_id, class_name: "Player"
  belongs_to :black_back_player, foreign_key: :black_back_player_id, class_name: "Player"
  belongs_to :yellow_front_player, foreign_key: :yellow_front_player_id, class_name: "Player"
  belongs_to :yellow_back_player, foreign_key: :yellow_back_player_id, class_name: "Player"

  validates_presence_of :black_back_player, :yellow_back_player, :black_front_player, :yellow_front_player
  validates :goals_yellow, :goals_black, allow_nil: true, :numericality => {only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 10}
  validate :result_fits_with_score

  def self.non_deleted
    where("deleted_at is null")
  end

  def self.last_month
    where("created_at > ?", 1.month.ago)
  end

  def destroy
    return true if deleted_at
    self.deleted_at = Time.now
    save(validate: false)
  end

  def result_fits_with_score
    return unless goals_yellow.present? && goals_black.present?

    if result && goals_yellow <= goals_black #yellow wins, but has less or equal goals to black
      errors.add(:goals_yellow, "Yellow has to score more goals than black to win.")
    elsif !result && goals_black <= goals_yellow #black wins, but has less or equal goals to black
      errors.add(:goals_black, "Black has to score more goals than black to win.")
    end
  end
end

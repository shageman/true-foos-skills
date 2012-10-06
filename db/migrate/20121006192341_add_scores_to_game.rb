class AddScoresToGame < ActiveRecord::Migration
  def change
    add_column :games, :goals_yellow, :integer
    add_column :games, :goals_black, :integer
  end
end

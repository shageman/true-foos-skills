class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.string :name
      t.float :mean, default: 100.0
      t.float :deviation, default: 100.0

      t.timestamps
    end
  end
end

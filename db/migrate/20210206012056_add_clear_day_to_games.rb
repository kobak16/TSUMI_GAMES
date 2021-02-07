class AddClearDayToGames < ActiveRecord::Migration[6.0]
  def change
    add_column :games, :clear_day, :datetime
  end
end

class AddColumnsToGames < ActiveRecord::Migration[6.0]
  def change
    add_column :games, :rate, :float
    add_column :games, :comment, :text
    add_column :games, :status, :integer, null: false
  end
end

class RemoveColumnsFromGames < ActiveRecord::Migration[6.0]
  def change
    remove_column :games, :rate, :float
    remove_column :games, :comment, :text
  end
end

class ChangeStatusOfGames < ActiveRecord::Migration[6.0]
  def change
    change_column_default(:games, :status, '0')
  end
end

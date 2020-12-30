class ChangeStatusOfGames < ActiveRecord::Migration[6.0]
  def up
    change_column_default(:games, :status, '0')
  end
end

class AddColumnsToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :sex, :integer, null: false
    add_column :users, :ages, :integer, null: false
  end
end
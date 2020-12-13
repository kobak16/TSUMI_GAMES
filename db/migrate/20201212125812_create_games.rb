class CreateGames < ActiveRecord::Migration[6.0]
  def change
    create_table :games do |t|
      t.string :title, null: false
      t.integer :genre, null: false, default: 0
      t.integer :machine, null: false, default: 0
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :games, :title
    add_index :games, :genre
    add_index :games, :machine
  end
end

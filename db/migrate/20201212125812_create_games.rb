class CreateGames < ActiveRecord::Migration[6.0]
  def change
    create_table :games do |t|
      t.string :title, null: false
      t.integer :genre, null: false
      t.integer :machine, null: false
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :games, :title
    add_index :games, :genre
    add_index :games, :machine
  end
end

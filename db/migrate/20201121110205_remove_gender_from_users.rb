class RemoveGenderFromUsers < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :gender, :string
  end
end

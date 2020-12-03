class AddUsernameAgeToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :username, :string
    add_column :users, :age, :text
  end
end

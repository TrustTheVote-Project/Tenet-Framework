class AddUniqueIndexes < ActiveRecord::Migration
  def change
    add_index :accounts, :name, unique: true
    add_index :users, :login, unique: true
  end
end

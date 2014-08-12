class AddOtpFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :ssh_public_key, :text
    add_index  :users, :ssh_public_key, unique: true
  end
end

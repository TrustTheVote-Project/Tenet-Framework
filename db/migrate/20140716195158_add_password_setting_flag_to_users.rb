class AddPasswordSettingFlagToUsers < ActiveRecord::Migration
  def change
    add_column :users, :password_set, :boolean, null: false, default: false
  end
end

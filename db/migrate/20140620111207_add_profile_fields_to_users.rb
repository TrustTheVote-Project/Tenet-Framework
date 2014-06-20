class AddProfileFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :csf_users, :phone, :string
    add_column :csf_users, :title, :string
  end
end

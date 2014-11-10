class AddFieldsToAccounts < ActiveRecord::Migration
  def change
    add_column :accounts, :website, :string
    add_column :accounts, :suspended, :boolean, null: false, default: false

    add_index  :accounts, :suspended
  end
end

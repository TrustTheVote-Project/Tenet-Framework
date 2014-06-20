class CreateCsfAccounts < ActiveRecord::Migration
  def change
    create_table :csf_accounts do |t|
      t.references :state, index: true
      t.string :name

      t.timestamps
    end
  end
end

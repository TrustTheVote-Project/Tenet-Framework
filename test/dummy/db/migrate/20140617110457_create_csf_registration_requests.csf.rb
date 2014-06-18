# This migration comes from csf (originally 20140617105509)
class CreateCsfRegistrationRequests < ActiveRecord::Migration
  def change
    create_table :csf_registration_requests do |t|
      t.string  :organization_name, null: false
      t.string  :state, null: false
      t.string  :website
      t.string  :admin_name, null: false
      t.string  :admin_title, null: false
      t.string  :admin_email, null: false
      t.string  :admin_phone
      t.boolean :archived, null: false, default: false

      t.timestamps
    end

    add_index :csf_registration_requests, :archived
  end
end

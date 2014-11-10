class AddRejectedToRegistrationRequests < ActiveRecord::Migration
  def change
    add_column :registration_requests, :rejected, :boolean, null: false, default: false
  end
end

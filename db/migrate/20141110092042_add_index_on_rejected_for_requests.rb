class AddIndexOnRejectedForRequests < ActiveRecord::Migration
  def change
    add_index :registration_requests, :rejected
  end
end

module Csf
  class State < ActiveRecord::Base
    has_many :accounts
    validates :code, presence: true
    validates :name, presence: true

    scope :with_accounts, -> { where(id: Csf::Account.pluck("DISTINCT(state_id)")) }
  end
end

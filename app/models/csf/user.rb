module Csf
  class User < ActiveRecord::Base
    authenticates_with_sorcery!

    belongs_to :account

    validates :account, presence: true
    validates :login, presence: true
    validates :email, presence: true, format: { with: /\A[^@\s]+@(?:[-a-zA-Z0-9]+\.)+[a-z]{2,}\z/, allow_blank: true }
    validates :password, presence: { on: :create }, confirmation: { if: :password }
    validates :first_name, presence: true
    validates :last_name, presence: true
  end
end

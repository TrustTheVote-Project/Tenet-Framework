module Csf
  class User < ActiveRecord::Base
    belongs_to :account

    validates :account, presence: true
    validates :login, presence: true
    validates :email, presence: true
    validates :first_name, presence: true
    validates :last_name, presence: true
  end
end

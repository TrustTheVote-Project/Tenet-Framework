module Csf
  class State < ActiveRecord::Base
    has_many :accounts
    validates :code, presence: true
    validates :name, presence: true
  end
end

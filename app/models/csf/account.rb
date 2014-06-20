module Csf
  class Account < ActiveRecord::Base
    belongs_to :state

    validates :state, presence: true
    validates :name, presence: true
  end
end

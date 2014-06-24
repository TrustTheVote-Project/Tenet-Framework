class Account < ActiveRecord::Base
  belongs_to :state
  has_many   :users, dependent: :destroy

  validates :state, presence: true
  validates :name, presence: true
end

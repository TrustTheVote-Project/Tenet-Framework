class Account < ActiveRecord::Base

  belongs_to :state
  has_many   :users, inverse_of: :account, dependent: :destroy

  validates :state, presence: true
  validates :name, presence: true, uniqueness: true

  accepts_nested_attributes_for :users

  include Concern::Suspension

  def self.new_from_request(req)
    a = Account.new
    a.state = State.find_by(code: req.state)
    a.name = req.organization_name

    a.users << User.new_from_request(req)

    a
  end

end

class Account < ActiveRecord::Base

  belongs_to :state
  has_many   :users, inverse_of: :account, dependent: :destroy
  has_many   :admins, -> { where(admin: true) }, inverse_of: :account, class_name: "User"

  validates :state, presence: true
  validates :name, presence: true, uniqueness: true

  accepts_nested_attributes_for :users

  include Concern::Suspension

  def self.new_from_request(req)
    a = Account.new
    a.state = State.find_by(code: req.state)
    a.name = req.organization_name
    a.website = req.website

    a.users << User.new_from_request(req)

    a
  end

  # Returns the first admin
  def admin
    admins.first
  end

end

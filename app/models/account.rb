class Account < ActiveRecord::Base

  belongs_to :state
  has_many   :users, inverse_of: :account, dependent: :destroy

  validates :state, presence: true
  validates :name, presence: true, uniqueness: true

  accepts_nested_attributes_for :users

  def self.new_from_request(req)
    a = Account.new
    a.state = State.find_by(code: req.state)
    a.name = req.organization_name

    u = User.new
    u.admin = true
    u.first_name = req.admin_name
    u.email = u.login = req.admin_email
    u.title = req.admin_title
    u.phone = req.admin_phone

    a.users << u

    a
  end
  
end

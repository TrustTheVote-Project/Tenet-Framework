class User < ActiveRecord::Base

  authenticates_with_sorcery!

  belongs_to :account, inverse_of: :users

  validates :account, presence: true
  validates :login, presence: true, uniqueness: true
  validates :email, presence: true, format: { with: /\A[^@\s]+@(?:[-a-zA-Z0-9]+\.)+[a-z]{2,}\z/, allow_blank: true }
  validates :password, presence: { on: :create }, confirmation: { if: :password, message: "doesn't match password" }
  validates :password, presence: { if: :resetting_password }
  validates :first_name, presence: true
  validates :last_name, presence: true

  scope :users_only, -> { where(admin: false) }

  attr_accessor :resetting_password
  attr_accessor :ssh_public_key

  before_validation :init_user, on: :create

  def full_name
    [ self.first_name, self.last_name ].reject(&:blank?).join(" ")
  end

  def user?
    !self.admin?
  end

  def never_logged_in?
    !self.last_login_at
  end

  private

  def init_user
    if self.admin?
      # Setting group admin password to 0000 initially, while
      # we don't have OTP working
      self.password = self.password_confirmation = '0000'
      self.password_set = true
    else
      self.login = self.email

      # Generating long unbreakable password and will ask the user to
      # reset it right away.
      self.password = self.password_confirmation = SecureRandom.hex
      self.password_set = false
    end

    true
  end

end

class User < ActiveRecord::Base

  authenticates_with_sorcery!

  belongs_to :account

  validates :account, presence: true
  validates :login, presence: true
  validates :email, presence: true, format: { with: /\A[^@\s]+@(?:[-a-zA-Z0-9]+\.)+[a-z]{2,}\z/, allow_blank: true }
  validates :password, presence: { on: :create }, confirmation: { if: :password }
  validates :first_name, presence: true
  validates :last_name, presence: true

  scope :users_only, -> { where(admin: false) }

  attr_reader :generated_password

  before_validation :init_user, on: :create, if: -> { !admin? }

  def full_name
    [ self.first_name, self.last_name ].reject(&:blank?).join(" ")
  end

  def user?
    !self.admin?
  end

  private

  def init_user
    self.login = self.email
    self.password = self.password_confirmation = @generated_password = SecureRandom.hex(4)
  end

end

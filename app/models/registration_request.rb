class RegistrationRequest < ActiveRecord::Base

  validates :organization_name, presence: true
  validates :state,       presence: true
  validates :website,     presence: true
  validates :admin_name,  presence: true
  validates :admin_title, presence: true
  validates :admin_email, presence: true
  validates :admin_phone, presence: true

end

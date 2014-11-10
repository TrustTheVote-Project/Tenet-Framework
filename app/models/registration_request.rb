class RegistrationRequest < ActiveRecord::Base

  validates :organization_name, presence: true
  validates :state,            presence: true
  validates :website,          presence: true
  validates :admin_first_name, presence: true
  validates :admin_last_name,  presence: true
  validates :admin_title,      presence: true
  validates :admin_email,      presence: true
  validates :admin_phone,      presence: true

  scope :unarchived,  -> { where(archived: false) }
  scope :active,      -> { where(archived: false, rejected: false) }
  scope :rejected,    -> { where(archived: false, rejected: true) }

  def archive!
    update_attribute(:archived, true)
  end

  # Rejects a request
  def reject!
    update_attributes!(rejected: true)
  end

  # Re-opens a rejected request
  def reopen!
    update_attributes!(rejected: false)
  end

  def admin_name
    [ self.admin_first_name, self.admin_last_name ].reject(&:blank?).join(' ')
  end

end

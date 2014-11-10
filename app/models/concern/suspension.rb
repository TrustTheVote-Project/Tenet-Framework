module Concern::Suspension
  extend ActiveSupport::Concern

  included do
    scope :active, -> { where(suspended: false) }
    scope :suspended, -> { where(suspended: true) }
  end

  def suspend!
    update_attributes!(suspended: true)
  end

  def unsuspend!
    update_attributes!(suspended: false)
  end

end

module Csf
  # Preview all emails at http://localhost:3000/rails/mailers/notifications
  class NotificationsPreview < ActionMailer::Preview

    # Preview this email at http://localhost:3000/rails/mailers/notifications/new_registration_request
    def new_registration_request
      Notifications.new_registration_request
    end

  end
end

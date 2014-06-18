require 'test_helper'

module Csf
  class NotificationsTest < ActionMailer::TestCase
    test "new_registration_request" do
      mail = Notifications.new_registration_request
      assert_equal "New registration request", mail.subject
      assert_equal ["to@example.org"], mail.to
      assert_equal ["from@example.com"], mail.from
      assert_match "Hi", mail.body.encoded
    end

  end
end

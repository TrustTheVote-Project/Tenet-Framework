module Csf
  class Notifications < ActionMailer::Base
    default from: CsfConfig['email']['noreply']

    def new_registration_request(req_id)
      @request = RegistrationRequest.find(req_id)
      mail to: CsfConfig['email']['superadmin']
    end
  end
end

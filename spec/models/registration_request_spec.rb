require 'spec_helper'

describe RegistrationRequest do

  it 'should mark the request as rejected' do
    r = create(:registration_request)
    r.reject!
    expect(r).to be_rejected
  end

  it 'should reopen the request' do
    r = create(:registration_request, :rejected)
    r.reopen!
    expect(r).not_to be_rejected
  end

end

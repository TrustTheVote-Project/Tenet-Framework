require 'spec_helper'

describe Account do

  it 'should return admins' do
    a     = create(:account)
    user  = create(:user, account: a)
    admin = create(:user, :admin, account: a)

    expect(a.users).to  match_array [ user, admin ]
    expect(a.admins).to match_array [ admin ]
    expect(a.admin).to  eq admin
  end

end

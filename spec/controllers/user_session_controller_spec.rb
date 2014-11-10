require 'spec_helper'

describe UserSessionsController, type: :controller do

  it 'should disallow users from suspended organizations' do
    a = create(:account, :suspended)
    u = create(:user, account: a)

    post :create, user_session: { state_id: a.state_id, account_id: a.id, type: 'user', login: u.login, password: "qwerty123456" }
    expect(response).to redirect_to :login
    expect(flash[:alert]).to eq I18n.t("user_sessions.create.organization_suspended")
  end

  it 'should disallow suspended users' do
    u = create(:user, :suspended)
    a = u.account

    post :create, user_session: { state_id: a.state_id, account_id: a.id, type: 'user', login: u.login, password: "qwerty123456" }
    expect(response).to redirect_to :login
    expect(flash[:alert]).to eq I18n.t("user_sessions.create.user_suspended")
  end

  it 'should allow user login' do
    u = create(:user)
    a = u.account

    post :create, user_session: { state_id: a.state_id, account_id: a.id, type: 'user', login: u.login, password: "qwerty123456" }
    expect(response).to redirect_to CsfConfig['urls']['user_dashboard']
  end

end

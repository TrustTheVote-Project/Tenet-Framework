require 'spec_helper'

describe GroupAdmin::UsersController, type: :controller do

  describe '#index' do
    let(:account) { create(:account) }
    let!(:active) { create(:user, account: account) }
    let!(:suspended) { create(:user, :suspended, account: account) }

    before do
      allow(@controller).to receive(:current_account).and_return(account)
    end

    it 'should render active users' do
      get :index
      expect(assigns(:users)).to eq [ active ]
      expect(response).to render_template :index
    end

    it 'should render suspended users' do
      get :suspended
      expect(assigns(:showing_suspended)).to be true
      expect(assigns(:users)).to eq [ suspended ]
      expect(response).to render_template :index
    end
  end
end

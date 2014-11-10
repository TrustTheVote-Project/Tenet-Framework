require 'spec_helper'

describe AdminAdmin::GroupsController, type: :controller do

  describe '#index' do
    let!(:active) { create(:account) }
    let!(:suspended) { create(:account, :suspended) }

    it 'should render active organizations' do
      get :index
      expect(assigns(:accounts)).to eq [ active ]
      expect(response).to render_template :index
    end

    it 'should render suspended organizations' do
      get :suspended
      expect(assigns(:accounts)).to eq [ suspended ]
      expect(response).to render_template :index
    end
  end

end

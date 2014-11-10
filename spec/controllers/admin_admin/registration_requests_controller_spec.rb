require 'spec_helper'

describe AdminAdmin::RegistrationRequestsController, type: :controller do

  describe '#index' do
    let!(:active) { create(:registration_request) }
    let!(:rejected) { create(:registration_request, :rejected) }

    it 'should render active requests' do
      get :index
      expect(assigns(:registration_requests)).to eq [ active ]
      expect(response).to render_template :index
    end

    it 'should render rejected requests' do
      get :rejected
      expect(assigns(:registration_requests)).to eq [ rejected ]
      expect(response).to render_template :index
    end
  end

end

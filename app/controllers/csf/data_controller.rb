module Csf
  class DataController < Csf::ApplicationController
    def organizations_in_state
      state = State.find(params[:state_id])
      render json: state.accounts.map { |a| { id: a.id, name: a.name } }
    end
  end
end

class AdminAdmin::RegistrationRequestsController < AdminAdmin::BaseController

  def index
    @registration_requests = RegistrationRequest.unarchived
  end

  def show
    @req = RegistrationRequest.find(params[:id])
  end

  def destroy
    @req = RegistrationRequest.find(params[:id])
    @req.destroy

    redirect_to :admin_admin_registration_requests, notice: t(".success")
  end

end

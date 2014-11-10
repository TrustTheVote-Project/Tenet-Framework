class AdminAdmin::RegistrationRequestsController < AdminAdmin::BaseController

  # Renders the list of all active requests
  def index
    @registration_requests = RegistrationRequest.active
  end

  # Renders the list of all rejected requests
  def rejected
    @registration_requests = RegistrationRequest.rejected
    @showing_rejected = true
    render :index
  end

  # Rejects the request
  def reject
    req = RegistrationRequest.find(params[:id])
    req.reject!
    redirect_to :back, notice: t(".success")
  rescue ActiveRecord::RecordNotFound
    redirect_to :back
  end

  # Reopens the request
  def reopen
    req = RegistrationRequest.find(params[:id])
    req.reopen!
    redirect_to :back, notice: t(".success")
  rescue ActiveRecord::RecordNotFound
    redirect_to :back
  end

  # Shows the details of a request
  def show
    @req = RegistrationRequest.find(params[:id])
  end

  # Deletes the request
  def destroy
    @req = RegistrationRequest.find(params[:id])
    @req.destroy

    redirect_to :admin_admin_registration_requests, notice: t(".success")
  end

end

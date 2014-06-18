class RegistrationRequestsController < ApplicationController

  before_filter :setup_gon_validations, only: [ :new, :create ]

  def new
    @request = RegistrationRequest.new
  end

  def create
    @request = RegistrationRequest.new(regreq_params)
    if @request.save
      Notifications.delay.new_registration_request(@request.id)
      redirect_to :root, notice: t(".success")
    else
      render :new
    end
  end

  private

  def regreq_params
    params[:registration_request].permit(:organization_name, :state, :website, :admin_name, :admin_title, :admin_email, :admin_phone)
  end

  def setup_gon_validations
    %w( required invalid_email invalid_phone invalid_website ).each do |k|
      gon.l[k] = I18n.t("validations.#{k}")
    end
  end

end

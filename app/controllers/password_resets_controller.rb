class PasswordResetsController < ApplicationController

  # request password reset
  def create
    @user = User.find_by(email: params[:email], admin: false)

    if @user
      @user.deliver_reset_password_instructions!
      redirect_to :root, notice: t("password_resets.create.success.#{@user.password_set? ? 'reset' : 'init'}")
    else
      redirect_to :root, alert: t('password_resets.user_not_found')
    end
  end

  # init / reset password form
  def edit
    @user = User.load_from_reset_password_token(@token = params[:token])
    if @user.blank?
      not_authenticated
      return
    end

    render @user.password_set? ? :edit : :init
  end

  # update the password
  def update
    @token = params[:token]
    @user = User.load_from_reset_password_token(params[:token])

    if @user.blank?
      not_authenticated
      return
    end

    password_reset = @user.password_set?

    # the next line makes the password confirmation validation work
    @user.resetting_password    = true
    @user.password_set          = true
    @user.password_confirmation = up[:password_confirmation]

    # the next line clears the temporary token and updates the password
    if @user.change_password!(up[:password])
      redirect_to :root, notice: t(password_reset ? ".success.reset" : ".success.init")
    else
      render password_reset ? :edit : :init
    end
  end

  private

  def up
    params[:user].permit(:password, :password_confirmation)
  end

end

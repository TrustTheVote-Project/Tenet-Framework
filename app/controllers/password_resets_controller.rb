class PasswordResetsController < ApplicationController

  # request password reset
  def create
    @user = User.find_by(email: params[:email], admin: false)

    if @user
      @user.deliver_reset_password_instructions!
      redirect_to :root, notice: I18n.t('password_resets.create.success')
    else
      redirect_to :root, alert: I18n.t('password_resets.user_not_found')
    end
  end

  # reset password form
  def edit
    @user = User.load_from_reset_password_token(@token = params[:token])
    not_authenticated if @user.blank?
  end

  # update the password
  def update
    @token = params[:token]
    @user = User.load_from_reset_password_token(params[:token])

    if @user.blank?
      not_authenticated
      return
    end

    # the next line makes the password confirmation validation work
    @user.resetting_password    = true
    @user.password_confirmation = up[:password_confirmation]

    # the next line clears the temporary token and updates the password
    if @user.change_password!(up[:password])
      redirect_to :root, notice: t('.success')
    else
      render :edit
    end
  end

  private

  def up
    params[:user].permit(:password, :password_confirmation)
  end

end

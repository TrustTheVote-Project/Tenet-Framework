class ProfileController < ApplicationController

  before_filter :require_login

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if params[:current_password]
      change_password
    else
      update_profile
    end
  end

  private

  def update_profile
    if @user.update_attributes(update_params)
      redirect_to :edit_profile, notice: t('.success_update_profile')
    else
      render :edit
    end
  end

  def change_password
    unless User.authenticate(@user.login, params[:current_password]) == @user
      @user.errors.add(:base, t('.current_password_invalid'))
      render :edit
      return
    end

    if @user.update_attributes(password_params)
      redirect_to :edit_profile, notice: t('.success_change_password')
    else
      render :edit
    end
  end

  def update_params
    params[:profile].permit(:first_name, :last_name, :title, :phone)
  end

  def password_params
    params[:profile].permit(:password, :password_confirmation)
  end

end

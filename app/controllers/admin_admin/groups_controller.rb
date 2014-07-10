class AdminAdmin::GroupsController < AdminAdmin::BaseController

  def index
    @accounts = Account.order("name")
  end

  def show
    @account = Account.find(params[:id])
  end
  
  def destroy
    @account = Account.find(params[:id])
    @account.destroy

    redirect_to :admin_admin_groups, notice: t(".success")
  end

end

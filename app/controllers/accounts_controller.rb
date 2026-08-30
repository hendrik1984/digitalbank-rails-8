class AccountsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @accounts = current_user.accounts
  end

  def show
    @account = current_user.accounts.find(params[:id])
  end

  def new
    @account = current_user.accounts.build
  end

  def create
    @account = current_user.accounts.build(account_params)
    
    if @account.save
      redirect_to accounts_path, notice: "Account created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def account_params
    params.required(:account).permit(:currency)
  end
end

class DepositsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_account
  
  def index
    @account = current_user.accounts.find(params[:account_id])
    @deposits = @account.deposits
                .search(params[:q])
                .order(created_at: :desc)
                .page(params[:page])
                .per(10)
  end

  def new
    @deposit = @account.deposits.build
    @payment_methods = PaymentGatewayClient.new.payment_methods

  rescue StandardError => e
    flash[:error] = "Payment Gateway unavailable, Please try again later."
    redirect_to accounts_path and return
  end

  def create
    @deposit = @account.deposits.build(deposits_params)
    @deposit.currency = @account.currency

    if @deposit.save
      PaymentGatewayClient.new.create_payment_transaction(@deposit)
      redirect_to accounts_path, notice: "Deposit request submitted for [Account Number <b>#{@account.account_number}</b>]."
    else
      @payment_methods = PaymentGatewayClient.new.payment_methods
      render :new, status: :unprocessable_entity
    end

  rescue StandardError => e
    Rails.logger.error("Payment Gateway error: #{e.message}")

    @deposit.destroy

    redirect_to accounts_path, notice: "Payment Gateway error: #{e.message}"
  end

  private

  def set_account
    @account = current_user.accounts.find(params[:account_id])
  end

  def deposits_params
    params.require(:deposit).permit(:amount, :payment_method_code)
  end
end

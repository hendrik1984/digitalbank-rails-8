class Api::V1::PaymentWebhooksController < ApplicationController
  wrap_parameters false
  skip_forgery_protection
  # skip_before_action :verify_authenticity_token

  def create
    deposit = Deposit.find_by!(reference: params[:reference])
    
    case params[:status]
    when "successful"
      Deposits::Complete.new(deposit).call
    when "failed"
      Deposits::Fail.new(deposit).call
    else
      return render json: {
        error: "Invalid payment status"
      }, status: :unprocessable_entity
    end

    render json: {
      message: "Webhook processed successfully"
    }, status: :ok
  end
end

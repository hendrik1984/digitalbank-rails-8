class Api::V1::PaymentWebhooksController < ApplicationController
  skip_forgery_protection

  def create
    Rails.logger.info(
      "Payment webhook received: #{params.to_unsafe_h}"
    )

    head :ok
  end
end

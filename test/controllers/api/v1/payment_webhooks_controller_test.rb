require "test_helper"

class Api::V1::PaymentWebhooksControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get api_v1_payment_webhooks_create_url
    assert_response :success
  end
end

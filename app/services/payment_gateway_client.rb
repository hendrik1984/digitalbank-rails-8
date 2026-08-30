class PaymentGatewayClient
    require 'net/http'

    def initialize
        @base_url = ENV.fetch("PAYMENT_GATEWAY_URL")
        @api_key = ENV.fetch("PAYMENT_GATEWAY_API_KEY")
    end

    def payment_methods
        get("/api/v1/payment_methods")
    end

    def create_payment_transaction(deposit)
        post(
            "/api/v1/payment_transactions",
            {
                reference: deposit.reference,
                amount: deposit.amount,
                currency: deposit.currency,
                payment_method_code: deposit.payment_method_code
            }
        )
    end

    private

    def get(path)
        request(Net::HTTP::Get, path)
    end

    def post(path, body)
        request(Net::HTTP::Post, path, body)
    end

    def request(http_method, path, body = nil)
        uri = URI.join(@base_url, path)

        request = http_method.new(uri)
        request["Content-Type"] = "application/json"
        request["X-API-Key"] = @api_key

        request.body = body.to_json if body
        
        response = Net::HTTP.start(uri.host, uri.port) do |http|
            http.request(request)
        end

        unless response.is_a?(Net::HTTPSuccess)
            raise "Payment Gateway request failed: #{response.code}"
        end

        JSON.parse(response.body)
    end
end
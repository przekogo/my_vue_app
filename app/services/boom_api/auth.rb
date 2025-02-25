module BoomApi
  class Auth < Base
    AUTH_PATH = '/open_api/v1/auth/token'

    def self.token
      @token ||= fetch_token
    end

    def self.fetch_token
      response = auth_connection.post(AUTH_PATH, {
        client_id: Rails.application.credentials.dig(:boom_api, :client_id),
        client_secret: Rails.application.credentials.dig(:boom_api, :client_secret)
      })

      token = response.body['access_token']

      if token
        Rails.logger.info("BoomAPI token fetched successfully.")
        token
      else
        Rails.logger.error("Failed to fetch token. Response: #{response.body}")
        raise StandardError, "Failed to fetch BoomAPI token."
      end
    end

    private
  
    def self.auth_connection
      Faraday.new(url: BASE_URL) do |conn|
        conn.request :json
        conn.response :json, content_type: /\bjson$/
        conn.adapter Faraday.default_adapter
      end
    end
  end
end

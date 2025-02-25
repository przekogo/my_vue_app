require 'faraday'
require 'faraday_middleware'

module BoomApi
  class Base
    BASE_URL = 'https://app.boomnow.com'

    def self.call(params = {})
      new.call(params)
    end

    def connection
      @connection ||= Faraday.new(url: BASE_URL) do |conn|
        conn.request :json
        conn.response :json, content_type: /\bjson$/
        conn.headers['Accept'] = 'application/json'
        conn.headers['Authorization'] = "Bearer #{BoomApi::Auth.token}"
        conn.adapter Faraday.default_adapter
      end
    end

    def get(path, params = {})
      response = connection.get(path, params)
      handle_response(response)
    end

    private

    def handle_response(response)
      if response.success?
        response.body
      else
        Rails.logger.error("BoomAPI Error: #{response.status} - #{response.body}")
        raise StandardError, "API call failed with status #{response.status}"
      end
    end
  end
end

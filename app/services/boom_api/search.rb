module BoomApi
  class Search < Base
    LISTINGS_PATH = '/open_api/v1/listings'

    def self.call(city:, adults:)
      new.call(city: city, adults: adults)
    end

    def call(city:, adults:)
      params = { city: city, adults: adults }
      get(LISTINGS_PATH, params)
    end
  end
end

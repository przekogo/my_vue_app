module BoomApi
  class Cities < Base
    CITIES_PATH = '/open_api/v1/listings/cities'

    def self.call
      new.call
    end

    def call
      get(CITIES_PATH)
    end
  end
end

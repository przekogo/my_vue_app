class Api::CitiesController < ApplicationController
  def index
    cities = ::BoomApi::Cities.call
    render json: cities
  rescue StandardError => e
    render json: { error: e.message }, status: :bad_gateway
  end
end

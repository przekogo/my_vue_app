class Api::SearchController < ApplicationController
  def index
    results = ::BoomApi::Search.call(city: params[:city], adults: params[:adults])
    render json: results
  rescue StandardError => e
    render json: { error: e.message }, status: :bad_gateway
  end
end
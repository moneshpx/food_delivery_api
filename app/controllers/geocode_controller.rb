class GeocodeController < ApplicationController
  def geocode
    address = params[:address]
    byebug
    results = Geocoder.search(address)

    if results.present?
      result = results.first
      render json: {
        status: 'success',
        address: address,
        coordinates: {
          latitude: result.latitude,
          longitude: result.longitude
        }
      }
    else
      render json: { status: 'error', message: 'Geocoding failed' }, status: :unprocessable_entity
    end
  end
end

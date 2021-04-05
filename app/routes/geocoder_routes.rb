class GeocoderRoutes < Application
  helpers Geocoder

  namespace '/v1' do
    get do
      result = Geocoder.geocode(params[:city])

      if result.present?
        status 201
        json result
      else
        status 422
        json I18n.t(:not_found, scope: 'api.errors')
      end
    end
  end
end

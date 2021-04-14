class GeocoderRoutes < Application
  helpers Geocoder

  namespace '/v1' do
    get do
      result = Geocoder.geocode(params[:city])

      if result.present?
        status 200
        json result
      else
        status 404
        json I18n.t(:not_found, scope: 'api.errors')
      end
    end
  end
end

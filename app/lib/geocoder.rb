require 'csv'

module Geocoder
  extend self

  DATA_PATH = Application.root.concat('/db/data/city.csv')

  def geocode(city)
    start_time = Time.now.to_f
    result = data[city]
    duration_time = (Time.now.to_f - start_time) * 1000
    Metrics.geocoding_request_duration_seconds.observe(duration_time.round, labels: { service: 'geocoder' })

    result
  end

  def data
    @data ||= load_data!
  end

  private

  def load_data!
    @data = CSV.read(DATA_PATH, headers: true).inject({}) do |result, row|
      city = row['city']
      lat = row['geo_lat'].to_f
      lon = row['geo_lon'].to_f
      result[city] = [lat, lon]
      result
    end
  end
end

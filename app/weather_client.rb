require 'byebug'
require 'dotenv/load'
require 'faraday'
require 'json'

class WeatherClient
  # Make Faraday connection injectable for easier testing.
  # See https://lostisland.github.io/faraday/adapters/testing for more details.
  def initialize(conn = nil)
    @conn = conn || Faraday.new(
      url: 'https://api.weatherapi.com/v1',
      params: { key: ENV['WEATHER_API_KEY'] },
      headers: { 'Accept' => 'application/json' }
    )
  end

  def today(city:)
    endpoint = 'current.json'
    params = { q: city, aqi: 'yes' }
    response = @conn.get(endpoint, params)
    parse_today(JSON.parse(response.body))
  end

  private

  def parse_today(json)
    location = json['location']
    current = json['current']
    condition = current['condition']
    "Weather for #{location['name']}, #{location['country']} is #{current['temp_c']} degrees. #{condition['text']}.\
 Air quality is #{air_quality(current['air_quality']['us-epa-index'])}"
  end

  def air_quality(aq_val)
    aq_map = {
      1 => 'Good',
      2 => 'Moderate',
      3 => 'Unhealthy for sensitive groups',
      4 => 'Unhealthy',
      5 => 'Very Unhealthy',
      6 => 'Hazardous'
    }
    aq_map[aq_val] || 'Unknown'
  end
end

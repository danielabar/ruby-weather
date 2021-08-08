require './app/weather_client'

RSpec.describe WeatherClient do
  let(:stubs) { Faraday::Adapter::Test::Stubs.new }
  let(:conn) { Faraday.new { |b| b.adapter(:test, stubs) } }
  let(:client) { described_class.new(conn) }

  # Clear default connection to prevent it from being cached between different tests.
  # This allows for each test to have its own set of stubs
  after do
    Faraday.default_connection = nil
  end

  describe '#today' do
    it 'gets current weather for a city' do
      # Block yields an array with 3 items:
      #   1. HTTP response code
      #   2. Hash of headers
      #   3. String response body
      stubs.get('current.json') do
        [
          200,
          { 'Content-Type': 'application/json' },
          '{"location":{"name":"Paris","country":"France"},"current":{"temp_c":16.0,"condition":{"text":"Clear"},"air_quality":{"us-epa-index":1}}}'
        ]
      end

      paris_weather = client.today(city: 'Paris')
      expect(paris_weather).to eq('Weather for Paris, France is 16.0 degrees. Clear. Air quality is Good')
      stubs.verify_stubbed_calls
    end
  end
end

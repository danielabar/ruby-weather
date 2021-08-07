require './app/weather_client'

# rubocop:disable Layout/LineLength
RSpec.describe WeatherClient do
  describe '#today' do
    it 'gets current weather for a city' do
      # stub Faraday `get` method to return a canned response
      response_dbl = instance_double('Faraday::Response')
      allow(Faraday).to receive(:get)
        .with('https://api.weatherapi.com/v1/current.json',
              {
                key: ENV['WEATHER_API_KEY'],
                q: 'Paris',
                aqi: 'yes'
              },
              { 'Accept' => 'application/json' })
        .and_return(response_dbl)
      allow(response_dbl).to receive(:body)
        .and_return('{"location":{"name":"Paris","country":"France"},"current":{"temp_c":16.0,"condition":{"text":"Clear"},"air_quality":{"us-epa-index":1}}}')

      paris_weather = described_class.new.today(city: 'Paris')
      expect(paris_weather).to eq('Weather for Paris, France is 16.0 degrees. Clear. Air quality is Good')
    end
  end
end
# rubocop:enable Layout/LineLength

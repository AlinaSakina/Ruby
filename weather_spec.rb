require 'rspec'
require 'vcr'
require_relative 'weather'

RSpec.describe WeatherAPI do
  let(:api_key) { '481db3f700decc2e6e8248ccc5abd7a5' }
  let(:weather_api) { WeatherAPI.new(api_key) }

  it 'fetches weather data successfully' do
    VCR.use_cassette('weather_fetch') do
      weather_data = weather_api.fetch_weather('Kharkov')
      expect(weather_data).to include(:city, :temperature, :humidity, :wind_speed)
    end
  end

  it 'saves data to CSV file' do
    VCR.use_cassette('weather_fetch') do
      weather_data = weather_api.fetch_weather('Kharkov')
      expect(File.exist?('weather_data.csv')).to be true

      csv_content = CSV.read('weather_data.csv', headers: true)
      expect(csv_content[0]['City']).to eq(weather_data[:city])
      expect(csv_content[0]['Temperature']).to eq(weather_data[:temperature].to_s)
      expect(csv_content[0]['Humidity']).to eq(weather_data[:humidity].to_s)
      expect(csv_content[0]['Wind Speed']).to eq(weather_data[:wind_speed].to_s)
    end
  end
end


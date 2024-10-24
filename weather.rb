require 'httparty'
require 'csv'

class WeatherAPI
  BASE_URL = 'https://api.openweathermap.org/data/2.5/weather'

  def initialize(api_key)
    @api_key = api_key
  end

  def fetch_weather(city)
    response = HTTParty.get(BASE_URL, query: { q: city, appid: @api_key, units: 'metric' })

    raise 'Error fetching data' unless response.success?

    weather_data = parse_weather_data(response)
    save_to_csv(weather_data)
    weather_data
  end

  private

  def parse_weather_data(response)
    {
      city: response['name'],
      temperature: response['main']['temp'],
      humidity: response['main']['humidity'],
      wind_speed: response['wind']['speed']
    }
  end

  def save_to_csv(data)
    CSV.open("weather_data.csv", "w") do |csv|
      csv << ["City", "Temperature", "Humidity", "Wind Speed"]
      csv << [data[:city], data[:temperature], data[:humidity], data[:wind_speed]]
    end
  end
end

api_key = '481db3f700decc2e6e8248ccc5abd7a5'
weather_api = WeatherAPI.new(api_key)

begin
  weather_data = weather_api.fetch_weather('Kharkov')
  puts "Weather data saved to weather_data.csv"
  puts weather_data
rescue => e
  puts e.message
end





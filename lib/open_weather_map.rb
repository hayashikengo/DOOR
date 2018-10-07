class OpenWeatherMap
  require "json"
  require "open-uri"
  
  BASE_URL = "https://api.openweathermap.org/data/2.5/forecast".freeze
  TOKYO_CITY_ID = '1850147'

  # tokyo: key='id', val='1850147'
  # akashi: key='q', val='Akashi'
  def self.get(key = 'id', val = TOKYO_CITY_ID)
    url = BASE_URL + "?#{key}=#{val}&APPID=#{ENV['Open_Weather_Map_API_KEY']}"

    puts "Request method:GET, URL:#{url}"
    json_response = open(url)
    JSON.parse(json_response.read)
  end

  # def self.get_icon_binary(icon)
  #   url = "http://openweathermap.org/img/w/#{icon}.png"
  #   open(url)
  # end
end
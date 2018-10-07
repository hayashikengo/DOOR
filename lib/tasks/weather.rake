namespace :weather do
  desc "お天気情報メッセージプッシュ通知（3時間毎実行）"
  task :line_push_batch => :environment do
    puts "Start weather check..."
    tokyo_city_id = '1850147'
    tokyo_weather_infos = OpenWeatherMap.get('id', tokyo_city_id)
    @now_time = Time.now
    
    city = tokyo_weather_infos['city']
    tokyo_weather_infos['list'].each do |weather_info|
      date_time = Time.parse(weather['dt_txt'])

      if now_weather?(date_time)
        # 今は何もしない
      elsif next_time_weather?(date_time)
        if need_alart?(weather)
          # TODO お天気警告
          create_message(weather_info['weather'])
        end
      end
    end
    puts "Finish weather check."
  end

  private

  def now_weather?(date_time)
    date_time <= @now_time && @now_time <= date_time + 3.hours
  end

  def next_time_weather?(date_time)
    date_time + 3.hours <= @now_time && @now_time <= date_time + 6.hours
  end

  def need_alart?(weather)
    # https://openweathermap.org/weather-conditions
    # Group 2xx: Thunderstorm
    # Group 3xx: Drizzle
    # Group 5xx: Rain
    # Group 6xx: Snow
    # Group 7xx: Atmosphere
    # Group 800: Clear
    # Group 80x: Clouds
    head_num = weather['id'].split('').first&.to_i
    [
      5
    ].include?(head_num)
  end

  def create_message(weather)
    # OPTIMIZE お天気アイコン画像送信（できたら）
    # weather['icon']
    # TODO メッセージ作成・Google翻訳
    weather['description']
  end
end

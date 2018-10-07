namespace :weather do
  desc "お天気情報メッセージプッシュ通知（3時間毎実行）"
  task :line_push_batch => :environment do
    puts "Start weather check..."
    tokyo_city_id = '1850147'
    tokyo_weather_infos = OpenWeatherMap.get('id', tokyo_city_id)
    @now_time = Time.now
    
    city = tokyo_weather_infos['city']
    tokyo_weather_infos['list'].each do |weather_info|
      date_time = Time.parse(weather_info['dt_txt'])
      weather = weather_info['weather'].first

      if now_weather?(date_time)
        # 今は何もしない
        pp "#{date_time} Now_weather: #{weather}"
      elsif next_time_weather?(date_time)
        if need_alart?(weather)
          # TODO お天気警告
          User.all.each_with_index do |user, i|
            next if user.line_user_id.blank?
            text = weather_message(weather).chomp
            response = send_message_text(text, user.line_user_id)
            puts "Sent message. to:#{user.displayName} line_user_id:#{user.line_user_id} response:#{response}"
          end
        end
        pp "#{date_time} Next_weather: #{weather}"
      else
        pp "#{date_time} #{weather}"
      end
    end
    puts "Finish weather check."
  end

  private

  def now_weather?(date_time)
    date_time <= @now_time && date_time + 3.hours >= @now_time
  end

  def next_time_weather?(date_time)
    date_time >= @now_time && date_time <= @now_time + 3.hours
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
    head_num = weather['id'].to_s.split('').first&.to_i
    [
      5,
      6
    ].include?(head_num)
  end

  def send_message_text(text, to)
    @line_bot_client ||= LineBotClient.new
    @line_bot_client.pushMessage('text', text, to)
  end

  def weather_message(weather)
    # OPTIMIZE お天気アイコン画像送信（できたら）
    # weather['icon']
    description = GoogleCloudTranslation.translate(weather['description'])

    <<-EOS
<天気>
東京都: #{description}
洗濯物など大丈夫でしょうか？
EOS
  end
end

namespace :patrol do
  desc "東京都の不審者情報取得"
  task :tokyo_police_page => :environment do
  SLEEP_TIME = 1.second.freeze

    puts "Start scrape..."
    agent = Mechanize.new
    top_page = agent.get("http://www.keishicho.metro.tokyo.jp/kurashi/higai/kodomo/fushin/index.html")
    sleep(SLEEP_TIME)
    detail_urls = top_page.search('.norcor').search('a').map{|e| e.get_attribute(:href) }
    detail_urls.each_with_index do |detail_url, i|
      sleep(SLEEP_TIME)
      # only scrape newest day
      break if i > 0

      # move to detail page
      detail_page = top_page.link_with(href: detail_url).click
      city_infos = detail_page.search('tr')
      city_infos.each do |city_info|
        # input suspicious person infomation
        city_name = city_info.children.search('th > p').children.first.text
        suspicious_person_info_text = city_info.children.search('td > p').first.children.map{ |a| a.text }.reject(&:empty?).join('\n')
        tx = city_info.children.search('ul > li').first&.children&.map{ |a| a.text }&.reject(&:empty?)&.join('\n')
        suspicious_person_info_text += "\n" + tx if tx

        if city = City.find_by(name: city_name)
          puts "find #{city_name}"
          city.suspicious_person_infos.find_or_create_by(
            text: suspicious_person_info_text,
            source_url: detail_url,
            published_at: Time.now.beginning_of_day)
        else
          puts "Error: Not found city name #{city_name}"
        end
      end
    end
    puts "Finish scrape.\n"

    puts "Start send message..."
    send_alart_push_message()
    puts "Finish send message."
  end

  def send_alart_push_message()
    SuspiciousPersonInfo.tell_infos.each do |line_user_id, cities|
      text = create_message_text(cities).chomp
      response = send_message_text(text, line_user_id.to_s)
      puts "Sent message. line_user_id:#{line_user_id} response:#{response}"
    end
  end

  def send_message_text(text, to)
    @line_bot_client ||= LineBotClient.new
    @line_bot_client.pushMessage('text', text, to)
  end

  def create_message_text(cities)
    # TODO 不審者情報が見やすいようなページを作成
    tokyo_police_page = "http://www.keishicho.metro.tokyo.jp/kurashi/higai/kodomo/fushin/index.html"
    <<-EOS
＜不審者情報＞
#{cities.map(&:name).join(', ')} にて不審者が確認されました。
#{tokyo_police_page}
EOS
  end
end

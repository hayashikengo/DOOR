namespace :patrol do
  desc "東京都の不審者情報取得"
  task :tokyo_police_page => :environment do
    puts "Start scrape..."
    agent = Mechanize.new
    top_page = agent.get("http://www.keishicho.metro.tokyo.jp/kurashi/higai/kodomo/fushin/index.html")
    detail_urls = top_page.search('.norcor').search('a').map{|e| e.get_attribute(:href) }
    detail_urls.each_with_index do |detail_url, i|
      # only scrape newest day
      break if i > 0

      # move to detail page
      detail_page = top_page.link_with(href: detail_url).click
      city_infos = detail_page.search('tr')
      city_infos.each do |city_info|
        # input suspicious person infomation
        city_name = city_info.children.search('th > p').children.first.text
        suspicious_person_info_text = city_info.children.search('td > p').first.children.map{ |a| a.text }.reject(&:empty?).join('\n')
        suspicious_person_info_text += "\n" + city_info.children.search('ul > li').first.children.map{ |a| a.text }.reject(&:empty?).join('\n')

        if city = City.find_by(name: city_name)
          puts "find #{city_name}"
          city.suspicious_person_infos.find_or_create_by(text: suspicious_person_info_text, published_at: Time.now.beginning_of_day)
        else
          puts "Error: Not found city name #{city_name}"
        end
      end
    end
    puts "Finish scrape."
  end
end

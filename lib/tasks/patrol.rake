namespace :patrol do
  desc "東京都の不審者情報取得"
  task :tokyo_police_page => :environment do
    agent = Mechanize.new
    top_page = agent.get("http://www.keishicho.metro.tokyo.jp/kurashi/higai/kodomo/fushin/index.html")
    detail_urls = top_page.search('.norcor').search('a').map{|e| e.get_attribute(:href) }
    detail_urls.each_with_index do |detail_url, i|
      # 最新の日にちの情報のみ取得
      next unless i == 0

      # move to detail page
      detail_page = top_page.link_with(href: detail_url).click
      city_infos = detail_page.search('tr')
      city_infos.each do |city_info|
        # input
        binding.pry
      end
    end
  end
end

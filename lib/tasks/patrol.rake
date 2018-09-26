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


    # スクレイピング先のURL
    # top_doc = getDoc('http://www.keishicho.metro.tokyo.jp/kurashi/higai/kodomo/fushin/index.html')
    # # 日毎の詳細ページURL取得
    # detail_urls = top_doc.css(".norcor").css("a").map{|a| a.attributes['href'].value}
    #
    # detail_urls.each do |detail_url|
    #   binding.pry
    #   detail_doc = getDoc(detail_url)
    #   binding.pry
    #   detail_doc
    # end
  end

  private

  # def getDoc(url)
  #   charset = nil
  #   html = open(url) do |f|
  #     charset = f.charset # 文字種別を取得
  #     f.read # htmlを読み込んで変数htmlに渡す
  #   end
  #   # htmlをパース(解析)してオブジェクトを作成
  #   Nokogiri::HTML.parse(html, nil, charset)
  # end
end

class GoogleTrendsManager
  def initialize(q='', geo='JP')
    @url = "https://trends.google.co.jp/trends/explore?q=#{q}&geo=#{geo}"
    puts "Start scrape..."
    puts "GET: #{@url}"
    # agent = Mechanize.new
    # @hit_page = agent.get(@url)
    if Rails.env == 'production'
      caps = Selenium::WebDriver::Remote::Capabilities.chrome(
        "chromeOptions" => {binary: "/app/.apt/usr/bin/google-chrome", args: ["--headless"]}
      )
    else
      caps = Selenium::WebDriver::Remote::Capabilities.chrome(
        "chromeOptions" => {args: ["--headless"]}
      )
    end
    @driver = Selenium::WebDriver.for :chrome, desired_capabilities: caps
    @driver.navigate.to(@url)


    # options = Selenium::WebDriver::Chrome::Options.new
    # options.add_argument('--headless')
    # driver = Selenium::WebDriver.for :chrome, options: options
    # driver.navigate.to 'https://www.google.co.jp/'
    # driver.save_screenshot './google.png'
    binding.pry
    
  end

  def get_trends

  end
end
require 'csv'
class GoogleTrendsManager
  def initialize(a = nil, b = nil)
    @csv_file = nil

    if a.class == ActionDispatch::Http::UploadedFile && b == nil
      import_csv_by_file(a)
    elsif a.class == String && b.class == String
      import_csv_by_crowl(a, b)
    else
      raise "Unexpected params."
    end
  end

  def get_trends
    return unless @csv_file
    trends = {}

    CSV.foreach(@csv_file.path, headers: false).with_index do |row, i|
      next if i < 3

      time, score = row
      trends[time] = score
    end

    trends
  end

  private

  def import_csv_by_file(file)
    @csv_file = file
  end

  def import_csv_by_crowl(q='', geo='JP')
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
  end
end
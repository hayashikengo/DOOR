class ApplicationController < ActionController::Base
  # callbackアクションのCSRFトークン認証を無効
  protect_from_forgery except: [:callback]

  # before_action :logger_request, only: [:callback]

  def logger_request()
    puts "*" * 50
    puts request
    puts "*" * 50
  end

  def client
    @client ||= Line::Bot::Client.new { |config|
      config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
      config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
    }
  end
end

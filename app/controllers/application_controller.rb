class ApplicationController < ActionController::Base
  # callbackアクションのCSRFトークン認証を無効
  protect_from_forgery except: [:callback]
  before_action :line_bot_auth, only: [:callback]
  # before_action :logger_request, only: [:callback]

  def line_bot_auth
    body = request.body.read

    signature = request.env['HTTP_X_LINE_SIGNATURE']
    unless client.validate_signature(body, signature)
      error 400 do 'Bad Request' end
    end
  end

  def client
    @client ||= Line::Bot::Client.new { |config|
      config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
      config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
    }
  end

  def logger_request()
    puts "*" * 50
    puts request
    puts "*" * 50
  end
end

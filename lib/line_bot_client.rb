require 'line/bot'
require 'dotenv'

class LineBotClient
  # OPTIMIZE このクラスにLineBotへのリクエストをまとめる

  # to: userId、groupId、またはroomId
  # https://developers.line.me/ja/reference/messaging-api/#anchor-0c00cb0f42b970892f7c3382f92620dca5a110fc
  def pushMessage(type='text', text="", to)
    message = {
      type: type,
      text: text
    }
    client.push_message(to, message)
  end

  private

  def client
    @@client ||= Line::Bot::Client.new { |config|
      config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
      config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
    }
  end
end
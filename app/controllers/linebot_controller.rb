class LinebotController < ApplicationController

  def callback
    body = request.body.read
    events = client.parse_events_from(body)

    events.each { |event|
      puts event['source']['userId']
      set_user(event['source']['userId'])
      case event
      when Line::Bot::Event::Message
        case event.type
        when Line::Bot::Event::MessageType::Text
          text_message = event.message['text']

          case text_message
          when /.*[市区町村].*(を追加して|を追加)/
            @user.add_watch_city(city_name)
          when /.*[市区町村].*(を削除して|を削除)/
            @user.delete_watch_city(city_name)
          when /不審者情報を教えて|不審者情報/
            send_reply_message(event['replyToken'], reply_message_text)
          else
            @user.add_messages(message_text)
            reply_message_text = @user.clova ?
                           (message_text + "\n以上を伝言板に登録しました！") :
                           "clovaをアプリで登録してください。"
            send_reply_message(event['replyToken'], reply_message_text)
          end
        end
      end
    }

    head :ok
  end

  def send_reply_message(replay_token, reply_message_text)
    message = {
      type: 'text',
      text: reply_message_text
    }
    client.reply_message(replay_token, message)
  end

  def set_user(line_user_id)
    @user = User.find_and_set_line_user_id(line_user_id)
  end
end

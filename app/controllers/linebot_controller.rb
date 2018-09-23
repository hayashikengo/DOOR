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
          @user.add_messages(text_message)
          send_reply_message(event['replyToken'],text_message)
        end
      end
    }

    head :ok
  end

  def send_reply_message(replay_token, message_text)
    replay_message_text = @user.clova ?
                     message_text + "\n以上を伝言板に登録しました！" :
                     "clovaをアプリで登録してください。"
    message = {
      type: 'text',
      text:replay_message_text
    }
    client.reply_message(replay_token, message)
  end

  def set_user(line_user_id)
    @user = User.find_and_set_line_user_id(line_user_id)
  end
end

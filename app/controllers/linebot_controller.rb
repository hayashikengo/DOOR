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
          send_reply_message(
            event['replyToken'],
            event.message['text']
          )
        end
      end
    }

    head :ok
  end

  def send_reply_message(replay_token, message_text)
    message = {
      type: 'text',
      text: message_text
    }
    client.reply_message(replay_token, message)
  end

  def set_user(line_user_id)
    @user = User.find_and_set_line_user_id(line_user_id)
  end
end

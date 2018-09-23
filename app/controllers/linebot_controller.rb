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
          message = {
            type: 'text',
            text: event.message['text']
          }
          client.reply_message(event['replyToken'], message)
        end
      end
    }

    head :ok
  end

  def set_user(line_user_id)
    @user = User.find_and_set_line_user_id(line_user_id)
  end
end

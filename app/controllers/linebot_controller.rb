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
          message_text = event.message['text']

          case message_text
          when /機能を教えて|使い方/
            reply_message_text = tell_func_text
          when /登録地区|登録地区を教えて/
            reply_message_text = watch_cities_text
          when /.*[市区町村].*(を追加して|を追加|を登録して|を登録)/
            city_name = message_text[/.*[市区町村]/]
            @user.add_watch_city(city_name)
            reply_message_text = "#{city_name}の不審者情報を通知します。"
          when /.*[市区町村].*(を削除して|を削除)/
            city_name = message_text[/.*[市区町村]/]
            @user.delete_watch_city(city_name)
            reply_message_text = "#{city_name}の不審者情報の通知を解除しました。"
          when /不審者情報を教えて|不審者情報/
            reply_message_text = suspicious_person_info_text
          else
            @user.add_messages(message_text)
            reply_message_text = @user.clova ?
                           (message_text + "\n以上を伝言板に登録しました！") :
                           "clovaをアプリで登録してください。"
          end
          send_reply_message(event['replyToken'], reply_message_text.chomp)
        end
      end
    }

    head :ok
  end

  def tell_func_text
    <<-EOS
＜伝言板機能＞
-「雨が降るから洗濯物片付けてね」...clovaでお伝えします
- 伝言板は複数お伝えできます
＜不審者情報通知＞
-「品川区を登録して」...品川区の通知を登録
-「品川区を削除して」...品川区の通知を解除
-「不審者情報を教えて」...登録された地区の不審者情報を通知
-「登録地区を教えて」...登録地区が表示されます
EOS
  end

  def suspicious_person_info_text
    suspicious_person_infos = @user.suspicious_person_infos_text.presence
    <<-EOS
#{suspicious_person_infos ? suspicious_person_infos : "現在不審者情報はありません。"}
#{watch_cities_text.chomp}
EOS
  end

  def watch_cities_text
    <<-EOS
<登録地区>
#{@user.cities.map(&:name).join(", ")}
EOS
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

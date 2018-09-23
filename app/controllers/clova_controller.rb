class ClovaController < ApplicationController
  require 'line/bot'
  before_action :set_clova, only: [:callback]

  def callback
    if to_user = @clova.user
      # クローバスキルが呼び出された時に返す返答
      # TODO メッセージを送信する
      send_push_message(to_user)
      @voice_message = "#{to_user.name}からの連絡です。。。"
      to_user.messages.should_send.each.with_index(1) do |i, message|
        # @voice_message += "#{i}件目です。"
        @voice_message += messages
      end
    else
      @voice_message = "LINEBotのDOOR(Perent)で伝言板に追加してください。"
    end

    render 'clova/callback', formats: 'json', handlers: 'jbuilder'
  end

  private

  # DOOR(Parent)へのプッシュ通知
  def send_push_message(to_user)
    text_message = "#{to_user.name}さんからの伝言をお伝えしました！"
    message = {
      type: 'text',
      text: text_message
    }
    response = client.push_message(to_user.line_user_id, message)
    p response
  end

  def set_clova
    line_user_id = params['session']['user']['userId']
    @clova = Clova.find_and_set_line_user_id(line_user_id)
  end
end

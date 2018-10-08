class ClovaController < ApplicationController
  require 'line/bot'
  before_action :set_clova, only: [:callback]
  before_action :set_shouldEndSession, only: [:callback]

  def callback
    @voice_message = nil

    pp @shouldEndSession
    if @shouldEndSession
      # ラインボットへ通知を送る
      send_push_message(to_user)

      # @voice_messageの設定
      set_voice_message
    end

    render 'clova/callback', formats: 'json', handlers: 'jbuilder'
  end

  private

  def set_shouldEndSession
    slots = params['request']['intent']['slots']
    pp "*" * 100
    pp params['request']['intent']
    pp params['request']['intent'].class
    pp params[:request][:intent][:slots]
    pp params.permit!.to_h[:request][:intent][:slots]
    pp params.permit!.to_h[:request][:intent]
    pp "*" * 100
    pp slots.nil? ? false : true

    @shouldEndSession = slots.nil? ? false : true
  end

  def set_voice_message
    if to_user = @clova.user
      @voice_message = "LINEBotのDOOR(Perent)で伝言板に追加してください。"
      return
    end
    
    # クローバスキルが呼び出された時に返す返答
    if messages = to_user.messages.presence
      @voice_message = "#{to_user.displayName}からの連絡です。。。"
      to_user.messages.should_send.each.with_index(1) do |message, i|
        # @voice_message += "#{i}件目です。"
        @voice_message += message.text + '。'
      end
    else
      @voice_message = "現在、伝言板にメッセージはありません。"
    end
  end

  # DOOR(Parent)へのプッシュ通知
  def send_push_message(to_user)
    text_message = "#{to_user.displayName}さんからの伝言をお伝えしました！"
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

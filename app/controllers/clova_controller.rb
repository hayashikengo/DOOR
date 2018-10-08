class ClovaController < ApplicationController
  require 'line/bot'
  before_action :set_clova, only: [:callback]
  before_action :set_shouldEndSession, only: [:callback]

  def callback
    @voice_message = "おかえりなさい！"

    if @shouldEndSession
      # ラインボットへ通知を送る
      send_push_message

      # @voice_messageの設定
      set_voice_message
    end

    render 'clova/callback', formats: 'json', handlers: 'jbuilder'
  end

  private

  def set_shouldEndSession
    slots = params['request']['intent']['slots']
    @shouldEndSession = slots.nil? ? false : true
  end

  def set_voice_message
    unless @to_user
      @voice_message = "LINEBotのDOOR(Perent)で伝言板に追加してください。"
      return
    end

    # クローバスキルが呼び出された時に返す返答
    if messages = @to_user.messages.presence
      @voice_message = "#{@to_user.displayName}からの連絡です。。。"
      @to_user.messages.should_send.each.with_index(1) do |message, i|
        # @voice_message += "#{i}件目です。"
        @voice_message += message.text + '。'
      end
    else
      @voice_message = "現在、伝言板にメッセージはありません。"
    end
  end

  # DOOR(Parent)へのプッシュ通知
  def send_push_message
    # text_message = "#{@to_user.displayName}さんからの伝言をお伝えしました！"
    text_message = "あなたの伝言が読まれました！"
    message = {
      type: 'text',
      text: text_message
    }
    response = client.push_message(@to_user.line_user_id, message)
    p response
  end

  def set_clova
    line_user_id = params['session']['user']['userId']
    @clova = Clova.find_and_set_line_user_id(line_user_id)
    @to_user = @clova.user
  end
end

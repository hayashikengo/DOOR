class ClovaController < ApplicationController
  require 'line/bot'
  before_action :set_clova, only: [:callback]

  def callback
    if to_user = @clova.user
      # TODO メッセージを送信する
      # send_push_message(to_user)
    else
      # TODO 「DOOR(Perent)でメッセージを送ってください」
    end

    render 'clova/callback', formats: 'json', handlers: 'jbuilder'
  end

  # def send_push_message(to_user)
  #   message = {
  #     type: 'text',
  #     text: 'hello'
  #   }
  #   response = client.push_message(to_user.line_user_id, message)
  #   p response
  # end

  def set_clova
    line_user_id = params['session']['user']['userId']
    @clova = Clova.find_and_set_line_user_id(line_user_id)
  end
end

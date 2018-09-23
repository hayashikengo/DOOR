class ClovaController < ApplicationController
  def callback
    # message = {
    #   type: 'text',
    #   text: 'hello'
    # }
    # # line_user_id =
    # response = client.push_message("userId", message)
    # p response
    p session.to_hash.to_s


    render 'clova/callback', formats: 'json', handlers: 'jbuilder'
  end
end

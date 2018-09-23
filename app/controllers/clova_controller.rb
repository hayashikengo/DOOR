class ClovaController < ApplicationController
  def callback
    # message = {
    #   type: 'text',
    #   text: 'hello'
    # }
    # # line_user_id =
    # response = client.push_message("userId", message)
    # p response
    body = request.body.read
    # p request
    p body
    p '*' * 50
    p body['session']


    render 'clova/callback', formats: 'json', handlers: 'jbuilder'
  end
end

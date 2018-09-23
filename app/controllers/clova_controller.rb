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
    p request
    p '*' * 50
    p body


    render 'clova/callback', formats: 'json', handlers: 'jbuilder'
  end
end

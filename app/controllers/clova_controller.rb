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
    p '*' * 50
    p params
    p '*' * 50


    render 'clova/callback', formats: 'json', handlers: 'jbuilder'
  end

  def set_clova(line_user_id)
    @clova = Clova.find_and_set_line_user_id(line_user_id)
  end
end

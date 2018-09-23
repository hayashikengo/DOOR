class ClovaController < ApplicationController
  def callback

    render 'clova/callback', formats: 'json', handlers: 'jbuilder'
  end
end

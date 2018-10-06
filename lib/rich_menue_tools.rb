class RichMenueTools

  def create()
    response = cron.post do |req|
      req.url ''
      req.headers['Authorization'] = authorization_token
      req.headers['Content-Type'] = 'application/json'
      req.body create_body_json
    end

    # TODO return richMenuId
    response.body
  end

  def delete(richMenuId)
    cron.post do |req|
      req.url '/{richMenuId} '
      req.headers['Authorization'] = authorization_token
      req.headers['Content-Type'] = 'application/json'
    end
  end

  def upload_img(richMenuId, rich_img)
    cron.post do |req|
      req.url "/#{richMenuId}/content"
      req.headers['Authorization'] = authorization_token
      req.headers['Content-Type'] = 'application/json'
      req.body = rich_img
    end
  end

  def set_default_rich_menu()
    cron.post do |req|
      req.url "/#{richMenuId}/content"
      req.headers['Authorization'] = authorization_token
      req.headers['Content-Type'] = 'application/json'
      req.body = rich_img
    end
  end

  def set_user_rich_menu()
    cron.post do |req|
      req.url "/#{richMenuId}/content"
      req.headers['Authorization'] = authorization_token
      req.headers['Content-Type'] = 'application/json'
      req.body = rich_img
    end
  end

  private

  def create_body_json
    # TODO リッチメニューオブジェクト
  end

  def cron
    @cron ||= Faraday.new(:url => 'https://api.line.me/v2/bot/richmenu') do |faraday|
      faraday.request  :url_encoded             # form-encode POST params
      faraday.response :logger                  # log requests to $stdout
      faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
    end
  end

  def authorization_token
    # TODO dev環境での設定
    " Bearer #{ENV["LINE_CHANNEL_TOKEN"]}"
  end
end

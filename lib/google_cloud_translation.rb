class  GoogleCloudTranslation
  # OPTIMIZE テーブル作って、同じ情報はapi叩かない
  def self.translate(string)
    url = URI.parse('https://www.googleapis.com/language/translate/v2')
    params = {
      q: string,
      target: "ja",
      source: "en",
      key: ENV['GOOGLE_CLOUD_TRAN_KEY']
    }
    url.query = URI.encode_www_form(params)
    res = Net::HTTP.get_response(url)

    JSON.parse(res.body)["data"]["translations"].first["translatedText"]
  end
end
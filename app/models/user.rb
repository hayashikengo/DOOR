class User < ApplicationRecord
  has_many :user_clovas
  has_many :clovas, through: :user_clovas
  has_many :messages, dependent: :destroy

  # TODO ユーザー名取得
  # validates :name, uniqueness: true, presence: true
  validates :line_user_id, uniqueness: true, presence: true

  def self.find_and_set_line_user_id(line_user_id)
    user = User.find_or_create_by(line_user_id: line_user_id)
    unless user.name
      get_line_user_profile
    end

    unless user.clova
      # 同じuserIdのClovaが存在する場合は、関連を追加
      clova = Clova.find_by(line_user_id: line_user_id)
      user.clovas << clova if clova
    end

    user
  end

  def displayName
    get_line_user_profile unless self.displayName

    self.displayName
  end

  def pictureUrl
    get_line_user_profile unless self.pictureUrl

    self.pictureUrl
  end

  def get_line_user_profile
    # TODO リファクタ
    client = Line::Bot::Client.new { |config|
      config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
      config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
    }
    response = client.get_profile(self.line_user_id)
    case response
    when Net::HTTPSuccess then
      contact = JSON.parse(response.body)
      p contact['displayName']
      p contact['pictureUrl']
      p contact['statusMessage']
      self.update_attributes(
        displayName: contact['displayName'],
        pictureUrl: contact['pictureUrl']
      )
      true
    else
      p "Error: #{response.code} #{response.body}"
      false
    end
  end

  # クローバで伝えるメッセージを保存
  def add_messages(text_message)
    self.messages.create(text: text_message)
  end

  def clova
    self.clovas.first
  end
end

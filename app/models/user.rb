class User < ApplicationRecord
  has_many :user_clovas
  has_many :clovas, through: :user_clovas

  # TODO ユーザー名取得
  # validates :name, uniqueness: true, presence: true
  validates :line_user_id, uniqueness: true, presence: true

  def self.find_and_set_line_user_id(line_user_id)
    user = User.find_or_create_by(line_user_id: line_user_id)
    unless user.name
      # TODO ユーザー名取得
      user.name = "名無し"
    end

    unless user.clova
      # 同じuserIdのClovaが存在する場合は、関連を追加
      clova = Clova.find_by(line_user_id: line_user_id)
      user.clovas << clova if clova
    end

    user
  end

  def clova
    self.clovas.first
  end
end

class Clova < ApplicationRecord
  has_many :user_clovas
  has_many :users, through: :user_clovas
  accepts_nested_attributes_for :user_clovas

  validates :line_user_id, uniqueness: true, presence: true

  def self.find_and_set_line_user_id(line_user_id)
    clova = Clova.find_or_create_by(line_user_id: line_user_id)

    # 同じuserIdのUserが存在する場合は、関連を追加
    user = User.find_by(line_user_id: line_user_id)
    clova.users << user if user

    clova
  end

  def user
    self.users.first
  end
end

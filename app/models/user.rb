class User < ApplicationRecord
  has_many :user_clovas
  has_many :clovas, through: :user_clovas

  validates :user_name, uniqueness: true
end

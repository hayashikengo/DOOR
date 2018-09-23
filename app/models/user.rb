class User < ApplicationRecord
  has_many :user_clovas
  has_many :clovas, through: :user_clovas

  validates :name, uniqueness: true, presence: true
end

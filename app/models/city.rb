class City < ApplicationRecord
  belongs_to :prefecture
  has_many :patrol_user_cities
  has_many :users, through: :patrol_user_cities

  validates :name, uniqueness: true
end

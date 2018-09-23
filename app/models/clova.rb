class Clova < ApplicationRecord
  has_many :user_clovas
  has_many :users, through: :user_clovas
  accepts_nested_attributes_for :user_clovas
end

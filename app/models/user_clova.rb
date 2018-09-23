class UserClova < ApplicationRecord
  belongs_to :user
  belongs_to :clova
  validates :line_user_id, uniqueness: true
end

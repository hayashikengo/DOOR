class SuspiciousPersonInfo < ApplicationRecord
  belongs_to :city

  validates :published_at, presence: true
  validates :text, presence: true
end

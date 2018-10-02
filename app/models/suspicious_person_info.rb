class SuspiciousPersonInfo < ApplicationRecord
  belongs_to :city

  validates :published_at, presence: true
  validates :text, presence: true

  scope :tell_targets, -> {
    where("published_at >= ? and published_at <= ?",
      Time.now.beginning_of_day - 1.day,
      Time.now.end_of_day
    )
  }
end

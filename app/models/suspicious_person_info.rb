class SuspiciousPersonInfo < ApplicationRecord
  belongs_to :city

  validates :published_at, presence: true
  validates :text, presence: true

  scope :today, -> {
    where("published_at >= ? and published_at <= ?",
      Time.now.beginning_of_day,
      Time.now.end_of_day
    )
  }

  scope :tell_targets, -> {
    where("published_at >= ? and published_at <= ?",
      Time.now.beginning_of_day - 1.day,
      Time.now.end_of_day
    )
  }

  def self.today_infos_text
    SuspiciousPersonInfo.all.tell_targets.map{ |suspicious_person_info|
      suspicious_person_info.text
    }.join("\n\n")
    .gsub("\\n", "\n")
  end
end

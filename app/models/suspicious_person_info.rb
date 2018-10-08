class SuspiciousPersonInfo < ApplicationRecord
  belongs_to :city

  validates :published_at, presence: true
  validates :text, presence: true
  validates :source_url, presence: true

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

  def self.tell_infos
    tell_infos = {}
    # self.tell_targets.each do |suspicious_person_info|
    self.tell_targets.each do |suspicious_person_info|
      city = suspicious_person_info.city
      city.users.each do |user|
        tell_infos[user.line_user_id.to_s] = [] unless tell_infos[user.line_user_id.to_s].present?
        tell_infos[user.line_user_id.to_s] << city unless tell_infos[user.line_user_id.to_s].include?(city)
      end
    end
    tell_infos
  end

  def self.today_infos_text
    SuspiciousPersonInfo.all.tell_targets.map{ |suspicious_person_info|
      suspicious_person_info.text
    }.join("\n\n")
    .gsub("\\n", "\n")
  end
end

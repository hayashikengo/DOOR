class Message < ApplicationRecord
  belongs_to :user

  scope :read, -> { where.not(read_at: nil) }
  scope :not_read, -> { where(read_at: nil) }
  scope :should_send, -> {
    where("created_at > ? and created_at < ?",
      Time.now - 1.day,
      Time.now
    )
  }

  validates :text, presence: true
end

class Message < ApplicationRecord
  validates :message, presence: true
  belongs_to :user
  belongs_to :room
  validates :message, length: { in: 0..140 }
end

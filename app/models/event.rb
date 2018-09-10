class Event < ApplicationRecord
  belongs_to :user
  belongs_to :board
  validates :title, presence: true, length: {maximum: 140}
  validates :description, length: {maximum: 1024}
  validates :repeater, numericality: { only_integer: true }
  validates :completed, inclusion: { in: [true, false] }
  validates :tags, length: {maximum: 140}
  validates :start_date, presence: true
  validates :deadline, presence: true
  validates :user_id, presence: true
  validates :board_id, presence: true


end

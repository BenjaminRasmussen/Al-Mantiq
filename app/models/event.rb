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
  validate :deadline_is_possible?
  validates :user_id, presence: true
  validates :board_id, presence: true

  def deadline_is_possible?
    return if [deadline.blank?, start_date.blank?].any?
     if deadline > start_date
       errors.add(:deadline, 'must be possible')
     end
  end

  def taglist
    taglist ||= self.tags.split
    taglist = taglist.map(&:downcase)
  end

end

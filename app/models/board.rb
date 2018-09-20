class Board < ApplicationRecord
  include Rails.application.routes.url_helpers
  has_many :board_user_relations
  has_many :users, through: :board_user_relations
  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 50 }
  has_many :events

end

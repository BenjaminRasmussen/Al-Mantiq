class Board < ApplicationRecord
  include Rails.application.routes.url_helpers
  has_many :board_user_relations
  has_many :users, through: :board_user_relations
  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 50 }
  has_many :events

  # This returns a list of boards relevant to the user
  def self.for(user)
    @boards = []
    Array(BoardUserRelation.where(user_id: user.id)).each do |f|
      @boards.push(Board.find(f.board_id))
    end
    Array(Board.where(user_id: user.id)).each do |f|
      @boards.push(f)
    end
  end

  # This returns a list of board ids relevant to the user
  def self.for_by_id(user)
    @boards_id = []
    Array(BoardUserRelation.where(user_id: user.id)).each do |f|
      @boards_id.push(Board.find(f.board_id).id)
    end
    Array(Board.where(user_id: user.id)).each do |f|
      @boards_id.push(f.id)
    end
  end

end

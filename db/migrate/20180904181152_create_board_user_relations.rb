class CreateBoardUserRelations < ActiveRecord::Migration[5.1]
  def change
    create_table :board_user_relations do |t|
      t.belongs_to :board, index:true
      t.belongs_to :user, index:true

      t.timestamps
    end
  end
end

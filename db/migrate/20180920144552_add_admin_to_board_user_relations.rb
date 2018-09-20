class AddAdminToBoardUserRelations < ActiveRecord::Migration[5.1]
  def change
    add_column :board_user_relations, :admin, :boolean, default: false
  end
end

class CreateBoards < ActiveRecord::Migration[5.1]
  def change
    create_table :boards do |t|
      t.string :title
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :boards, [:user_id, :created_at]
  end
end

class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.string :title
      t.text :description
      t.integer :repeater
      t.boolean :completed
      t.string :tags
      t.date :start_date
      t.date :deadline
      t.references :user, foreign_key: true
      t.references :board, foreign_key: true

      t.timestamps
    end
  end
end

class ChangeDateFormatInEvents < ActiveRecord::Migration[5.1]
  def up
    change_column :events, :start_date, :date
    change_column :events, :deadline, :date

  end

  def down
    change_column :events, :start_date, :datetime
    change_column :events, :deadline, :datetime

  end
end

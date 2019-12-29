class ModifyEvents < ActiveRecord::Migration[6.0]
  def change
    remove_column :events, :start_date, :datetime
    remove_column :events, :end_date, :datetime
  end
end

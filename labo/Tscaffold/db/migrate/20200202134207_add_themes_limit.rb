class AddThemesLimit < ActiveRecord::Migration[6.0]
  def change
    add_column :themes, :limit, :date
  end
end

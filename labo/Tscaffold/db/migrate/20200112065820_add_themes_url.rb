class AddThemesUrl < ActiveRecord::Migration[6.0]
  def change
    add_column :themes, :url, :string
  end
end

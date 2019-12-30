class AddUrlTokenToEvents < ActiveRecord::Migration[6.0]
  def change
    add_column :events, :url_token, :string
  end
end

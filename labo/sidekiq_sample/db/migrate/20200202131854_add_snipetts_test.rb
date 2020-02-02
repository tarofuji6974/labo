class AddSnipettsTest < ActiveRecord::Migration[6.0]
  def change
    add_column :snippets, :highlighted_code, :text
    add_column :snippets, :language, :string
    add_column :snippets, :plain_code, :text
  end
end

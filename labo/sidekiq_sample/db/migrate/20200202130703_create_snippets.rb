class CreateSnippets < ActiveRecord::Migration[6.0]
  def change
    create_table :snippets do |t|

      t.timestamps
    end
  end
end

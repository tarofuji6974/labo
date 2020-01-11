class CreateThemes < ActiveRecord::Migration[6.0]
  def change
    create_table :themes do |t|
      t.string :theme
      t.integer :user_id
      t.string :user_name
      t.string :status

      t.timestamps
    end
  end
end

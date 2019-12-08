class AddImageNameToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :photos, :image_name, :string
    add_column :photos, :user_name, :string
  end
end

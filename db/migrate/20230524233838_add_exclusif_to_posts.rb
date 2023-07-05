class AddExclusifToPosts < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :exclusif, :boolean
  end
end

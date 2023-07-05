class AddFanToPosts < ActiveRecord::Migration[7.0]
  def change
    add_reference :posts, :fan, null: true, foreign_key: true
  end
end

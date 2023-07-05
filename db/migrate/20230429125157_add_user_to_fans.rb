class AddUserToFans < ActiveRecord::Migration[7.0]
  def change
    add_reference :fans, :user, null: true, foreign_key: true
  end
end

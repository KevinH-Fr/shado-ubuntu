class AddUserToAthletes < ActiveRecord::Migration[7.0]
  def change
    add_reference :athletes, :user, null: true, foreign_key: true
  end
end

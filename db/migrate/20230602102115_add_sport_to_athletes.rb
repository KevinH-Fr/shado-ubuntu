class AddSportToAthletes < ActiveRecord::Migration[7.0]
  def change
    add_reference :athletes, :sport, null: true, foreign_key: true
  end
end

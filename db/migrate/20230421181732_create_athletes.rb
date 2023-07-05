class CreateAthletes < ActiveRecord::Migration[7.0]
  def change
    create_table :athletes do |t|
      t.string :name
      t.string :discipline
      t.text :bio

      t.timestamps
    end
  end
end

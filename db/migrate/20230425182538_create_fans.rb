class CreateFans < ActiveRecord::Migration[7.0]
  def change
    create_table :fans do |t|
      t.string :pseudo
      t.text :bio

      t.timestamps
    end
  end
end

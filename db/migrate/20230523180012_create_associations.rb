class CreateAssociations < ActiveRecord::Migration[7.0]
  def change
    create_table :associations do |t|
      t.references :athlete, null: false, foreign_key: true
      t.references :fan, null: false, foreign_key: true

      t.timestamps
    end
  end
end

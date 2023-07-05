class CreateCampaigns < ActiveRecord::Migration[7.0]
  def change
    create_table :campaigns do |t|
      t.string :title
      t.text :description
      t.boolean :periodicity
      t.decimal :subscription
      t.integer :target
      t.date :start
      t.date :end
      t.references :athlete, null: false, foreign_key: true

      t.timestamps
    end
  end
end

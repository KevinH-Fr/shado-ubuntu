class CreateSubscriptions < ActiveRecord::Migration[7.0]
  def change
    create_table :subscriptions do |t|
      t.references :campaign, null: false, foreign_key: true
      t.references :fan, null: false, foreign_key: true

      t.timestamps
    end
  end
end

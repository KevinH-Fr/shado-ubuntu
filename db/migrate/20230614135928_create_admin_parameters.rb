class CreateAdminParameters < ActiveRecord::Migration[7.0]
  def change
    create_table :admin_parameters do |t|
      t.integer :remuneration

      t.timestamps
    end
  end
end

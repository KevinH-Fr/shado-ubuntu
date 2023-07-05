class AddPricesToSubscriptions < ActiveRecord::Migration[7.0]
  def change
    add_column :subscriptions, :brut, :decimal
    add_column :subscriptions, :net, :decimal
  end
end

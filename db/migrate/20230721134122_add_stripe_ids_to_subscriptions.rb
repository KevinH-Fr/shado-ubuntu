class AddStripeIdsToSubscriptions < ActiveRecord::Migration[7.0]
  def change
    add_column :subscriptions, :stripe_product_id, :string
    add_column :subscriptions, :stripe_customer_id, :string
  end
end

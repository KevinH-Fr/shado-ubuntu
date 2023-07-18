class AddStripeColumnsToCampaigns < ActiveRecord::Migration[7.0]
  def change
    add_column :campaigns, :stripe_product_id, :string
    add_column :campaigns, :stripe_price_id, :string
  end
end

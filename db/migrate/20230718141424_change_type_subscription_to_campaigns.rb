class ChangeTypeSubscriptionToCampaigns < ActiveRecord::Migration[7.0]
  def change
    change_column :campaigns, :subscription, :integer
  end
end

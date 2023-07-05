class AddThankyounoteToCampaigns < ActiveRecord::Migration[7.0]
  def change
    add_column :campaigns, :thankyounote, :text
  end
end

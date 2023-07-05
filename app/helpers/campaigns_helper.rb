module CampaignsHelper
    def campaign_label(campaign)
        if campaign.periodicity == true
            "Annuelle"
        else 
            "Ponctuelle"
        end
    end


end

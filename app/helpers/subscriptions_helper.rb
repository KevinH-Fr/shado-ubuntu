module SubscriptionsHelper
    def sub_count(campaign)
        Subscription.where(campaign_id: campaign).count
    end

    def sub_current_fan(campaign, fan)
        Subscription.where(campaign_id: campaign, fan_id: fan)
    end


    def subscription_presence(campaign, fan)
        Subscription.where(campaign_id: campaign, fan_id: fan).present?
    end

    def subscription_id(campaign, fan)
        Subscription.where(campaign_id: campaign, fan_id: fan).ids
    end
end

module NotificationsHelper
    def icon_notification(notification)
        case notification
        when "PostNotification"
            content_tag :i, "", class: "fa fa-xl text-warning fa-bullhorn me-4"
        when "CommentNotification"
            content_tag :i, "", class: "fa fa-xl text-primary fa-regular fa-comment me-4"

        when "LikePostNotification"
            content_tag :i, "", class: "fa fa-xl text-danger fa-regular fa-heart me-4"

        when "SubscriptionNotification"
            content_tag :i, "", class: "fa fa-xl text-success fa-solid fa-money-bill-trend-up me-4"

        else
            content_tag :i, "", class: "fa fa-xl fa-question-circle me-4"
        end 
    end
end

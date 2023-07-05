class Subscription < ApplicationRecord
  belongs_to :campaign
  belongs_to :fan

  after_create_commit :notify_recipient 
  before_destroy :cleanup_notifications
  has_noticed_notifications model_name: 'Notification'

  private 
  
  def notify_recipient
    recipient = User.find(self.campaign.athlete.user_id)

    SubscriptionNotification.with(subscription: self)
      .deliver_later(recipient)
  end

  def cleanup_notifications lo
    notifications_as_comment.destroy_all
  end

end

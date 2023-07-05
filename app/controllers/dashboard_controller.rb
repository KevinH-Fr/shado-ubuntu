class DashboardController < ApplicationController
  def index
    
  end
  
  def activities
    @athlete = Athlete.where(user_id: current_user.id).first
    @followers = @athlete.fans.uniq

        
    @subscriptions = @athlete.campaigns.joins(:subscriptions)
    @nbFansByDate = @subscriptions.group('DATE(subscriptions.created_at)').count
    
    @valSubscriptions = @subscriptions.sum(:brut)
    
    @valSubByDate = @subscriptions.group('DATE(subscriptions.created_at)').sum('brut')
    @nbSubByDate = @subscriptions.group('DATE(subscriptions.created_at)').count

    @posts = @athlete.posts

    @posts_without_media = @posts.select { |post| !post.media.attached? } 
    @posts_with_images = @posts.select { |post| post.media.attached? && post.media.image? }
    @posts_with_videos = @posts.select { |post| post.media.attached? && post.media.video? } 

    
  end

  def revenues
    @athlete = Athlete.where(user_id: current_user.id).first
        
    @subscriptions = @athlete.campaigns.joins(:subscriptions)
    
    @valSubscriptions = @subscriptions.sum(:brut)


    
    @valSubByDate = @subscriptions.group('DATE(subscriptions.created_at)').sum('brut')
    @nbSubByDate = @subscriptions.group('DATE(subscriptions.created_at)').count

  end

  def monetization
    @athlete = Athlete.where(user_id: current_user.id).first
    @campaigns = @athlete.campaigns

    @main_campaign = @athlete.campaigns.where(periodicity: true).first
    @popup_campaigns = @athlete.campaigns.where(periodicity: false)

  end

  def guides
  end

end

class StepsSubscribeController < ApplicationController

  include UsersHelper

  def step1
    @athlete = Athlete.find(params[:athlete])
    @campaign = Campaign.where(athlete_id:  @athlete, periodicity: true).first

  end

  def step2
    @athlete = Athlete.find(params[:athlete])
    @campaign = Campaign.where(athlete_id:  @athlete, periodicity: true).first
    @subscription = Subscription.new
    @fan =  Fan.find(user_role_id(current_user))

    @remuneration = AdminParameter.first.remuneration

    @totalPrice = @campaign.subscription
    @platformFees = @totalPrice * ( @remuneration.to_f / 100)
    @paymentFees = @totalPrice * ( 1.5 / 100)

    @paymentFeesForfait = 0.5
    @paymentFeesPourcentage = 0.1
    @paymentFeesPourcentageApplied = @paymentFeesPourcentage * @totalPrice

    @netAthlete = @totalPrice - @platformFees - @paymentFeesForfait - @paymentFeesPourcentageApplied

  end

  def step3

 #   @campaignThankNote = @campaign.thankyounote
    @fan =  Fan.find(user_role_id(current_user))

   @lastSubscriptionByFan = Subscription.where(fan_id: @fan.id).last
   @campaign = Campaign.find(@lastSubscriptionByFan.campaign_id)
   @thankyounote = @campaign.thankyounote

  end

end

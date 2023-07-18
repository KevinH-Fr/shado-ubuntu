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


    @session_with_expand = Stripe::Checkout::Session
    .retrieve({ id: params[:session_id], expand: ["line_items"] }) 

  @session_with_expand.line_items.data.each do |line_item|
    @product_id = Campaign.find_by(stripe_product_id: line_item.price.product)
  end
  
 #   @campaignThankNote = @campaign.thankyounote
    @fan =  Fan.find(user_role_id(current_user))

   @lastSubscriptionByFan = Subscription.where(fan_id: @fan.id).last
   @campaign = Campaign.find(@lastSubscriptionByFan.campaign_id)
   @thankyounote = @campaign.thankyounote

  end


end

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

  
  def create_checkout_session 
    session = Stripe::Checkout::Session.create({
      line_items: [{
        price: 'price_1NQBM4AGIT8oyD13qP5IVsxd',
        quantity: 1,
      }],
      mode: 'payment',
      success_url: 'https://example.com/success',  # Replace with your actual success URL
      cancel_url: 'https://example.com/cancel',    # Replace with your actual cancel URL
      })

      redirect_to session.url, allow_other_host: true, status: 303
  end



end

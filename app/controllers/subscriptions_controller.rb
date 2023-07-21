class SubscriptionsController < ApplicationController

  include UsersHelper 

  before_action :set_subscription, only: %i[ show edit update destroy ]

  def index
    @subscriptions = Subscription.all
  end

  def show
    mark_notifications_as_read
  end

  def new
    @subscription = Subscription.new
    if params[:subscription_type] = "main"
      @athlete = Athlete.find(params[:athlete])
      @campaign = Campaign.where(athlete_id: @athlete.id, periodicity: true).first
    end 

    @fan = Fan.where(user_id: current_user.id).first


  end

  def edit
  end

  def create

    campaign_id = params[:subscription][:campaign_id]
    puts "___________________ #{campaign_id}"


    # Handle the Stripe payment flow here
    product = Campaign.find(campaign_id)


    puts "_________________ periodicity: #{product.periodicity}"

    puts "___________________ #{product.subscription}"


      if product.periodicity == true 
        session = Stripe::Checkout::Session.create({
          mode: 'subscription',
          payment_method_types: ['card'],
          line_items: [
            {
              price: product.stripe_price_id,
              quantity: 1,
            }
          ],
          success_url: success_url + "?session_id={CHECKOUT_SESSION_ID}",
          cancel_url: cancel_url,
        })
      else 
        session = Stripe::Checkout::Session.create({
          mode: 'payment',
          payment_method_types: ['card'],
          line_items: [
            {
              price: product.stripe_price_id,
              quantity: 1,
            }
          ],
          success_url: success_url + "?session_id={CHECKOUT_SESSION_ID}",
          cancel_url: cancel_url,
        })

      end 
  
      redirect_to session.url, allow_other_host: true, status: 303

      puts "___________________ #{Fan.find(user_role_id(current_user.id)).id}"

      fan_id = Fan.find(user_role_id(current_user.id)).id
      customer_stripe = current_user.stripe_customer_id

      # Create the sale record in your database 
      # then the webhook update the status?
      @subscription = Subscription.create(
        campaign_id: product.id,
        fan_id: fan_id,
        brut: product.subscription,
        stripe_product_id: product.stripe_product_id,
        stripe_customer_id: customer_stripe
      )

  end

  def success
  end

  def cancel
  end

  def update
    respond_to do |format|
      if @subscription.update(subscription_params)
        format.html { redirect_to subscription_url(@subscription), notice: "Subscription was successfully updated." }
        format.json { render :show, status: :ok, location: @subscription }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @subscription.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @subscription.destroy

    respond_to do |format|
      format.html { redirect_to subscriptions_url, notice: "Subscription was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_subscription
      @subscription = Subscription.find(params[:id])
    end

    def subscription_params
      params.require(:subscription).permit(:campaign_id, :fan_id, :brut, :net, :stripe_product_id,
        :stripe_customer_id, :status )
    end

    def mark_notifications_as_read
      if current_user 
        subscription = Subscription.find(params[:id])
        notifications_to_mark_as_read = subscription.notifications_as_subscription.where(recipient: current_user)
        notifications_to_mark_as_read.update_all(read_at: Time.new)
      end
    end

end
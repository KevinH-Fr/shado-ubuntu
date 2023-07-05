class SubscriptionsController < ApplicationController
  before_action :set_subscription, only: %i[ show edit update destroy ]

  def index
    @subscriptions = Subscription.all
  end

  def show
    mark_notifications_as_read
  end

  def new
    @subscription = Subscription.new
    @campaign = Campaign.find(params[:id])
    @fan = Fan.where(user_id: current_user.id).first


  end

  def edit
  end

  def create
    @subscription = Subscription.new(subscription_params)


    respond_to do |format|
      if @subscription.save
        format.html { redirect_to steps_subscribe_step3_path, notice: "Subscription was successfully created." }
        format.json { render :show, status: :created, location: @subscription }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @subscription.errors, status: :unprocessable_entity }
      end
    end
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
      params.require(:subscription).permit(:campaign_id, :fan_id, :brut, :net)
    end

    def mark_notifications_as_read
      if current_user 
        subscription = Subscription.find(params[:id])
        notifications_to_mark_as_read = subscription.notifications_as_subscription.where(recipient: current_user)
        notifications_to_mark_as_read.update_all(read_at: Time.new)
      end
    end

end

class CampaignsController < ApplicationController
  before_action :set_campaign, only: %i[ show edit update destroy ]

  def index
    @athlete = Athlete.find(params[:athlete_id])

    campaign_type = params[:campaign_type]

    if campaign_type == "main"
      @campaigns = @athlete.campaigns.where(periodicity: true )
    else 
      @campaigns = @athlete.campaigns
    end
  end

  def show
  end

  def new
    #@campaign = Campaign.find(params[:id])
    @campaign = Campaign.new
    @subscription = @campaign.subscriptions.new
    # Additional code for the new action
  end

  def edit
  end

  def create
    @campaign = Campaign.new(campaign_params)

    respond_to do |format|
      if @campaign.save
        format.html { redirect_to user_url(current_user), notice: "Campaign was successfully created." }
        format.json { render :show, status: :created, location: @campaign }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @campaign.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @campaign.update(campaign_params)
        format.html { redirect_to campaign_url(@campaign), notice: "Campaign was successfully updated." }
        format.json { render :show, status: :ok, location: @campaign }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @campaign.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @campaign.destroy

    respond_to do |format|
      format.html { redirect_to campaigns_url, notice: "Campaign was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_campaign
      @campaign = Campaign.find(params[:id])
    end

    def campaign_params
      params.require(:campaign).permit(:title, :description, :periodicity, :subscription, :target, :start, :end, :athlete_id, :thankyounote)
    end
end

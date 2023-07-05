class FansController < ApplicationController
  before_action :set_fan, only: %i[ show edit update destroy ]

  def index
    @fans = Fan.all
  end

  def show
    @user = User.find(@fan.user_id)
  end

  def new
    @fan = Fan.new
  end

  def edit
    respond_to do |format|
      format.html
      format.turbo_stream do  
        render turbo_stream: turbo_stream.update(@fan, partial: "fans/form", 
          locals: {fan: @fan})
      end
    end
  end

  def create
    @fan = Fan.new(fan_params)

    respond_to do |format|
      if @fan.save
        format.turbo_stream do
          flash.now[:notice] = "le fan #{@fan.id} a bien été ajouté"
          render turbo_stream: 
            turbo_stream.update("fan", partial: "fans/fan",
              locals: {fan: @fan })
        end
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @fan.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @fan.update(fan_params)
        format.turbo_stream do
          render turbo_stream: turbo_stream.update(@fan, partial: 'fans/fan', locals: { fan: @fan })
        end
        format.html { redirect_to fan_url(@fan), notice: "Fan was successfully updated." }
      else
        format.turbo_stream do
          render turbo_stream: turbo_stream.update(@fan, partial: 'fans/form', locals: { fan: @fan })
        end
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /fans/1 or /fans/1.json
  def destroy
    @fan.destroy

    respond_to do |format|
      format.html { redirect_to fans_url, notice: "Fan was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_fan
      @fan = Fan.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def fan_params
      params.require(:fan).permit(:pseudo, :bio, :user_id, :profile_pic)
    end
end

class AthletesController < ApplicationController
  before_action :set_athlete, only: %i[ show edit update destroy ]

  def index

    @fan = Fan.where(user_id: current_user.id).first if current_user
    @athletes_suivis = @fan.athletes if @fan.present?
 
    @q = Athlete.ransack(params[:q])

    if @q.present?
      @athletes = @q.result(distinct: true).order(created_at: :desc)
    else
      @athletes = Athlete.all
      @athletes_suivis = @fan.athletes.distinct if @fan.present?

    end

    if params[:sport].present?
      @athletes = Athlete.joins(:sport).where(sports: { name: params[:sport] })
      @athletes_suivis = @athletes_suivis.joins(:sport).where(sports: { name: params[:sport] }) if @athletes_suivis.present?
    end
    


  end

  def show
    #@posts =  Post.where(athlete_id: @athlete.id) 
    @posts = @athlete.posts
    @user = User.find(@athlete.user_id) if @user.present?
  end

  def new
    @athlete = Athlete.new
  end

  def edit
    @sports = Sport.all

    respond_to do |format|
      format.html
      format.turbo_stream do  
        render turbo_stream: turbo_stream.update(@athlete, partial: "athletes/form", 
          locals: {athlete: @athlete})
      end
    end
  end

  def create
    @athlete = Athlete.new(athlete_params)

    respond_to do |format|
      if @athlete.save
        format.html { redirect_to steps_athlete_step3_path(), notice: "Athlete was successfully created." }
        format.json { render :show, status: :created, location: @athlete }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @athlete.errors, status: :unprocessable_entity }
      end
    end
  end



  def update
    @sports = Sport.all

    respond_to do |format|
      if @athlete.update(athlete_params)
        format.html { redirect_to athlete_url(@athlete), notice: "Athlete was successfully updated." }
        format.json { render :show, status: :ok, location: @athlete }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @athlete.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @athlete.destroy

    respond_to do |format|
      format.html { redirect_to athletes_url, notice: "Athlete was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_athlete
      @athlete = Athlete.find(params[:id])
    end

    def athlete_params
      params.require(:athlete).permit(:name, :discipline, :bio, :user_id, :profile_pic, :panorama_pic, :sport_id)
    end
end

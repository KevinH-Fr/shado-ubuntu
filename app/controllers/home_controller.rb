class HomeController < ApplicationController

  include UsersHelper 

  def index
    @athlete = Athlete.where(user_id: current_user).first

    @q = Athlete.ransack(params[:q])
   @posts = Post.non_exclusif

    if current_user && user_role(current_user.id) == "fan" 
      @partial_role = 'fan_infos'
      @fan = Fan.find(user_role_id(current_user))
      @athletes = @fan.athletes.distinct

      @posts = Post.non_exclusif
      @posts_suivis = Post.where(athlete_id: @athletes.pluck(:id))


    elsif current_user && user_role(current_user) == "athlete" 
      @partial_role = 'athlete_infos'

      @campaigns = @athlete.campaigns 
      @followers = @athlete.fans
    end

  end
end

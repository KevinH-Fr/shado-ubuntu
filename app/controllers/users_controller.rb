class UsersController < ApplicationController
  def show
    @user = User.find(params[:id]) 
    @fan = Fan.where(user_id: current_user.id).first
    @athlete = Athlete.where(user_id: current_user.id).first
  end

  def index
    
  end

end

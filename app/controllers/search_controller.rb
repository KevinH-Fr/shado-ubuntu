class SearchController < ApplicationController
  def index
    @q = Athlete.ransack(params[:q])
  end
end

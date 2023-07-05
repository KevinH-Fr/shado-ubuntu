class FriendsController < ApplicationController
  before_action :set_friend, only: %i[ show edit update destroy ]

  # GET /friends or /friends.json
  def index
    @friends = Friend.all
  end

  # GET /friends/1 or /friends/1.json
  def show
  end

  # GET /friends/new
  def new
    @friend = Friend.new
  end

  # GET /friends/1/edit
  def edit
  end

  # POST /friends or /friends.json
  def create
    @friend = Friend.new(friend_params)

    respond_to do |format|
      if @friend.save
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.update('new_friend', partial: 'friends/form', locals: { friend: Friend.new }),
            turbo_stream.prepend('friends', partial: 'friends/friend', locals: { friend: @friend })
          ]
        end
      else
        format.turbo_stream do
          render turbo_stream: turbo_stream.update('new_friend', partial: 'friends/form', locals: { friend: @friend})
        end
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /friends/1 or /friends/1.json
  def update
    respond_to do |format|
      if @friend.update(friend_params)
        format.html { redirect_to friend_url(@friend), notice: "Friend was successfully updated." }
        format.json { render :show, status: :ok, location: @friend }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @friend.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /friends/1 or /friends/1.json
  def destroy
    @friend.destroy

    respond_to do |format|
      format.html { redirect_to friends_url, notice: "Friend was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_friend
      @friend = Friend.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def friend_params
      params.require(:friend).permit(:name)
    end
end

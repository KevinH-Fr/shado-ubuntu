class LikePostNotification < Noticed::Base

  include UsersHelper

    deliver_by :database # Store the notification in the database
  
  
    # Define the message content of the notification
    def message
      #athlete = Athlete.find(params[:post].athlete_id).name
      user = user_name(params[:liker])
      "post liked by #{user}"
    end

    def user_name_label
      user = user_name(params[:liker])
    end

    # Define the URL or path for the notification
    def url
      post_path(params[:post]) # Replace with the appropriate path helper for your app
    end
  end
  
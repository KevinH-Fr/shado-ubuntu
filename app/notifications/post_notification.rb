class PostNotification < Noticed::Base
    deliver_by :database # Store the notification in the database
  
  
    # Define the message content of the notification
    def message
      "post #{params[:post].id} created by "
    end
    
    def user_name_label
      athlete = Athlete.find(params[:post].athlete_id).name
    end
  
    # Define the URL or path for the notification
    def url
      post_path(params[:post]) # Replace with the appropriate path helper for your app
    end
  end
  
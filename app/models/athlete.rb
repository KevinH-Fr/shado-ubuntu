class Athlete < ApplicationRecord

    has_many :posts
   # has_many :associations
   # has_many :fans, through: :associations
 
   has_many :campaigns
   has_many :fans, through: :campaigns

   
   belongs_to :sport

   belongs_to :user



   has_one_attached :profile_pic
   has_one_attached :panorama_pic


   def after_create_path
    # Customize the logic to determine the redirect path based on your requirements
    puts " ------------- redirect to step 3"
    steps_athlete_step3_path()
  end
  
  def default_profile_pic
    if profile_pic.attached?
      profile_pic
    else
      'profile_default'
    end
  end

  def default_panorama_pic
    if panorama_pic.attached?
      panorama_pic
    else
      'panorama_default'
    end
  end

  def self.ransackable_attributes(auth_object = nil)
    ["bio", "created_at", "sport_id", "id", "name", "updated_at", "user_id"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["campaigns", "fans", "panorama_pic_attachment", "panorama_pic_blob", "posts", "profile_pic_attachment", "profile_pic_blob", "sport", "user"]
  end

end

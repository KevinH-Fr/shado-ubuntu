module PostsHelper
    def upvote_label(post, user)
        if current_user 
            label_text = if user.voted_up_on? post
                        # "unvote"
                        else 
                        # "upvote"
                        end
            tag.span do
                "#{post.cached_votes_up} #{label_text}"
            end
        end
    end 

    def downvote_label(post, user)
        label_text = if user.voted_down_on? post
                       # "unvote"
                    else 
                      #  "downvote"
                    end
        tag.span do
            "#{post.cached_votes_down} #{label_text}"
        end
    end

    def upvote_label_styles(post, user)
        if user.voted_up_on? post 
            #"background-color: grey;"
        end 
    end

    def downvote_label_styles(post, user)
        if user.voted_down_on? post 
           # "background-color: grey;"
        end 
    end
    
    def comments_related(post)
        post.comments
    end
end

module V1
  module Services
    class UserFollow
      class << self
        def follow_user(from, to)
          # Find the User records for the follower and the followed
          follower = User.find_by(id: from)
          followed = User.find_by(id: to)
          # good flow code for exiting after the issue is found in follower or followed
          byebug
          return unless follower && followed

          Follow.create(follower_id: follower.id, followed_id: followed.id)
        end

        def unfollow_user(from, to)
          # Find the Follow record to destroy
          follow_record = Follow.find_by(follower_id: from)
          return unless follow_record
          follow_record&.destroy
        end


        def get_all_followed(id)
          User.find(id).followed_users
        end
        def get_all_followers(id)
          User.find(id).followers
        end
      end
    end
  end
end

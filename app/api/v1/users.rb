module V1
class USERS<Grape::API
      desc "This is to get all the users"
      get do
          User.all
      end

      desc"Edit a user within itself"
      put do

      end





      # get all of the user followed
      params  do
            requires :id , type:Integer
      end
      post "followed" do
            V1::Services::UserFollow.get_all_followed(params[:id])
      end



      # get all of the user followers
      params  do
            requires :id , type:Integer
      end
      post "followers" do
            V1::Services::UserFollow.get_all_followers(params[:id])
      end



      params do
            requires :follower_id , type: Integer
            requires :followed_id , type: Integer
      end
      post "follow" do

            V1::Services::UserFollow.follow_user(params[:follower_id],params[:followed_id]);
      end


      params do
            requires :follower_id , type: Integer
            requires :followed_id , type: Integer
      end
      post "unfollow" do
            V1::Services::UserFollow.unfollow_user(params[:follower_id],params[:followed_id]);
      end
    end

end
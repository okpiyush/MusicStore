module V1

  class Follow<Grape::API
    post "follow" do
      V1::Services::Follow.follow_user("Abhi","Manyu");
    end
    post "unfollow" do
      V1::Services::Follow.unfollow_user("Abhi","Manyu");
    end
  end
end
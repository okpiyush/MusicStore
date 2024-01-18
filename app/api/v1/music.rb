module V1
  class MUSIC < Grape::API
    resource "music" do
      desc "This gets all the music"
      get do
        {message:"gets all music"}
      end
    end
  end
end
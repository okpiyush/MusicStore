module V1
  class MUSIC < Grape::API
    resource "music" do
      desc "This gets all the music"
      get do
        V1::Services::Music.get_all_songs
      end
      params do
        requires :name, type: String
        requires :singer, type: String
        requires :url, type: String
        requires :rating, type: Float
        requires :user, type: Integer
        requires :token, type: String
      end
      post do
        V1::Services::Music.create_song(params[:name],params[:singer],params[:url],params[:user],params[:rating],params[:token])
      end
      params do
        requires :id , type:Integer
      end
      post "/find"do
        V1::Services::Music::get_song(params[:id])
      end
      params do
        requires :user_id , type: Integer
      end
      post"/user"do
        V1::Services::Music::get_all_user_songs(params[:user_id])
      end
    end
  end
end
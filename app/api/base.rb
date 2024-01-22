require_relative './v1/auth'
require_relative './v1/users'
require_relative './v1/music'
class BASE < Grape::API

    format :json
    # API endpoint for auth
    mount V1::AUTH


    # API endpoint for MUSIC
    mount V1::MUSIC


    # API endpoint for USERS
    mount V1::USERS=>"user"



    #API endpoint for Likes



    #API endpoint for data and followups



    #API endpoint for test
    get "test" do
      {message:"this is test"}
    end
  end
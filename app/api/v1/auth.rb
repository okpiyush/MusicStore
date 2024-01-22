require_relative './Services/auth'
module V1

  class AUTH < Grape::API
    params do
      requires :email, type: String
      requires :password, type: String
      requires :name , type: String
    end
    post "signup" do
      V1::Services::Auth.signup(params[:name],params[:email],params[:password])
    end

    params do
      requires :email, type: String
      requires :password, type: String
    end
    post "login" do
      V1::Services::Auth.login(params[:email],params[:password])
    end


  end
end
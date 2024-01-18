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
    post "login" do
      V1::Services::Auth.login()
    end

  end
end
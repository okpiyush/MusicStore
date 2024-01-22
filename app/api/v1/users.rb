module V1
class USERS<Grape::API
      desc "This is to get all the users"
      get do
          User.all
      end

      desc "this is to get all details of a specific user"
      post "follow"do

      end

      desc"Edit a user within itself"
      put do

      end
    end

end
require_relative '../Helper/redishelper'

module V1
  module Services
    class Auth
      class << self
        TIME=24*60*60.freeze
        USER="user".freeze
        def signup(name,email,password)

          existing_user=User.find_by(email: email)

          if(existing_user)

            {error: "Email is already taken"}

          else

            #bad code : add name parameter here
            V1::Helper::Redishelper.get_set( cache:false , type:USER , expiry: TIME ) do

              user=User.create(name:name, email: email, password_digest:hash_password(password))

              token=generate_token(user)

              {id:user.id, token:token}

            end

          end

        end



        #cache false for not checking in the redis for the initial presence
        def login (email,password)
          user= User.find_by(email:email)
          return {message:"user not found"} if user.blank?

          if user && BCrypt::Password.new(user.password_digest)==password

            V1::Helper::Redishelper.get_set( id:user.id , cache:false  , type: USER ,expiry: TIME) do

              token=generate_token(user)

              {id:user.id,token:token.to_json}

            end

          else

            {message: "Wrong Password"}

          end

        end
        def auth(id,token)

          V1::Helper::Redishelper.auth(id,token)

        end


        private
        def generate_token(user)
          "#{user.email}-#{SecureRandom.hex(16)}"
        end

        def hash_password(password)
          BCrypt::Password.create(password)
        end
      end
    end
  end
end
require_relative '../Helper/redishelper'

module V1
  module Services
    class Auth
      class << self
        def signup(name,email,password)
          existing_user=User.find_by(email: email)
          if(existing_user)
            {error: "Email is already taken"}
          else
            V1::Helper::Redishelper.get_set(0,false,"user",86400)do
              user=User.create(name:name, email: email, password_digest:hash_password(password))
              token=generate_token(user)
              {id:user.id, token:token}
            end
          end
        end
        def login (email,password)
          user= User.find_by(email:email)
          if user && BCrypt::Password.new(user.password_digest)==password
            V1::Helper::Redishelper.get_set(user.id,true,"user",86400)do
              token=generate_token(user)
              {id:user.id,token:token}
            end
          end
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
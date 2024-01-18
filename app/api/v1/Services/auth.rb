module V1
  module Services
    class Auth
      class << self
        def signup(name,email,password)
          existing_user=User.find(email: email)
          if(existing_user)
            {error: "Email is already taken"}
          else
            user=User.create(name:name, email: email, password:hash_password(password))
            token=generate_token(user) #generate and hash password token is a private function
            {token: token}
          end
        end
        def login (email,password)
          user=User.find_by(email: email)
          if user && BCrypt::Password.new(User.password)==hash_password(password)
            token=generate_token(user)
            { token: token }
          else
            {error: "Invalid email or password"}
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
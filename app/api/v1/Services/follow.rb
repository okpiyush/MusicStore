module V1
  module Services
    class Follow
      class<<self
        def follow_user( from,to)

          { message: "#{from} just followed #{to}"}
        end

        def unfollow_user(from,to)

          { message: "#{from} just unfollowed #{to}"}
        end
      end
    end
  end
end
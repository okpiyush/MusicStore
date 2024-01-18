require 'redis'


module REDIS
  class Redis
    class<<self
      def save_token(token,user_id)
        redis= Redis.new

        expiration=24*60*60
        redis.setex("userid:#{user_id}",expiration,token)

      end
      def get_token(user_id,token)
        redis=Redis.new
        token = redis.get("userid:#{user_id}")
      end

      def save_songs(song)
        redis=Redis.new
        expiration =24*60*60
        redis.setex("songid:#{song.id}",expiration,song)
      end

      def get_song(song_id)
        redis=Redis.new
        song=redis.get("songid:#{song.id}")
      end
    end
  end
end
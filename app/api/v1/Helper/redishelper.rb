require 'redis'
module V1



  module Helper
    class Redishelper
      class << self
        # function to save object   in redis

        def get_set(id,cache,type,expiry,&block)
          value = cache ? get(id,type):nil
          if value.nil?
            value=block.call
            if value
              set(value[:id],type,expiry,value[:token])
              value=value[:token]
            end
          end
          value
        end
        def set(id,type,expiration,value)
          currkey="#{type}_id:#{id}"
          redis=Redis.new
          redis.setex(currkey,expiration,value)
        end

        #function to get object from redis
        def get(id,type)
          currkey="#{type}_id:#{id}"
          redis=Redis.new
          redis.get(currkey)
        end


        #
        #
        # def save_token(user_id,usertoken)
        #   expiration=24*60*60
        #   save_object_in_redis("userid:#{user_id}",expiration,usertoken)
        # end
        #
        # def get_token(user_id)
        #   token=get_object_in_redis("userid:#{user_id}")
        # end
        #
        #
        #
        #
        # def delete_a_key(key)
        #   redis=Redis.new
        #   redis.del(key)
        # end
        # def save_songs(song)
        #   expiration=24*60*60
        #   save_object_in_redis("song_id:#{song.id}",expiration,song.to_json)
        # end
        #
        # def get_song(song_id)
        #   song_json=get_object_in_redis("song_id:#{song_id}")
        #   JSON.parse(song_json) if song_json
        # end
        #
        #
        #
        #
        # def save_playlist(playlist)
        #   expiration=24*60*60
        #   save_object_in_redis("pl_id:#{playlist.id}",expiration,playlist.to_json)
        # end
        #
        # def get_playlist(playlist_id)
        #   pl_json=get_object_in_redis("pl_id:#{playlist_id}")
        #   JSON.parse(pl_json) if pl_json
        # end


      end
    end
  end
end
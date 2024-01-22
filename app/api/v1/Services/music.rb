module V1
  module Services
    class Music
      class<<self
        TIME=24*60*60.freeze
        MUSIC="music".freeze
        def create_song(name, singer, url, user, rating, token)
          return { message: "You aren't authenticated" } unless V1::Services::Auth.auth(user, token)

          song = Song.find_by(name: name)

          return { message: "Song exists" } if song.blank?

          user_instance = User.find(user)

          # Use the correct variable name 'rating'
          song = Song.create(name: name, singer: singer, url: url, user: user_instance, rating: rating)

          # Use 'song.id' instead of 'id' in 'V1::Helper::Redishelper.get_set'
          V1::Helper::Redishelper.get_set(id: song.id, cache: false, type: MUSIC, expiry: TIME) do
            song = Song.find_by(id: song.id)
            { id: song.id, token: song.to_json }
          end
        end

        def get_song(id)
          V1::Helper::Redishelper.get_set(id:id,cache:true,type:MUSIC,expiry: TIME)do
            song=Song.find_by(id:id)
            byebug
            {id:id,token:song.to_json}
          end
        end

        #because feed will get loaded we dont need to send all of the songs to the cache
        def get_all_songs()
          Song.all
        end

        def get_all_user_songs(user)
          Song.where(user_id:user)
        end

        def delete_song(id)
          Song.delete_by(id:id)
          V1::Helper::Redishelper.del(id)
        end
      end
    end
  end
end

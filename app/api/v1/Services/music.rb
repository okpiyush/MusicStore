module V1
  module Services
    class Music
      class<<self
        def create_song(name,singer,url,user,rating)
          song = Song.find_by(name: name)
          if(song)
            {message: "Song exists"}
          else
            Song.create(name: name, singer: singer, url: url,user: user, rating:rating)
            {message: "Song was created"}
          end

        end
        def edit_song(id,values)
          song= Song.find_by(id:id)
          if(song)
            song.update(name: values.name ,singer:values.singer, url:values.url,user:values.user,rating:values.rating)
          else
            {message:"Song is not present"}
          end
        end

        def get_song(id)
          song=Song.find_by(id)
        end

        def get_all_songs()
          Song.all
        end

        def delete_song(id)
          Song.delete_by(id:id)
        end
      end
    end
  end
end
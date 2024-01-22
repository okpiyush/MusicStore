require 'redis'
require 'connection_pool'

module V1
  module Helper
    class Redishelper
      REDIS_POOL_SIZE = 5
      REDIS_POOL_TIMEOUT = 5

      class << self
        def get_set(id: 0, cache: true, type: "user", expiry: 86400, &block)
          value = get(id, type) if cache

          if value.blank?

            value = block.call

            return { message: "#{type} not found" } unless value.present?

            set(value[:id], type, expiry, value[:token])

            value[:token]
          else
            JSON.parse(value)
          end

        end



        # Sets data in redis db
        def set(id, type, expiration, value)

          currkey = "#{type}_id:#{id}"

          with_redis_connection { |redis| redis.setex(currkey, expiration, value) }

        end


        # gets data from redis database
        def get(id, type)
          currkey = "#{type}_id:#{id}"

          with_redis_connection { |redis| redis.get(currkey) }

        end

        # Authenticates a user from redis
        def auth(id, token)

          currkey = "user_id:#{id}"

          old_token = with_redis_connection { |redis| redis.get(currkey) }

          token == JSON.parse(old_token)

        end

        # deletes a key from redis DB
        def delete_a_key(id,type)

          with_redis_connection { |redis| redis.del("#{type}_id:#{id}") }

        end

        private


        # sets pool for the redis connection which in turn uses the database only wiht one declaration.

        def with_redis_connection

          redis_pool.with { |redis| yield(redis) }

        end

        def redis_pool

          @redis_pool ||= ConnectionPool.new(size: REDIS_POOL_SIZE, timeout: REDIS_POOL_TIMEOUT) do

            Redis.new

          end

        end
      end
    end
  end
end

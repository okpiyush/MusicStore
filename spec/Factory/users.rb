require 'factory_bot_rails'

# spec/music_store/v1/songs_spec.rb

FactoryBot.define do
  factory :user do
    name {'Example song'}
    email {'this@email.com'}
    password {'thisisthepassword'}
  end
end
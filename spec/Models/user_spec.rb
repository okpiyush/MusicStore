require 'rails_helper'
require 'rack/test'
require_relative '../../app/api/base'
require 'factory_bot_rails'

FactoryBot.find_definitions
RSpec.describe V1::USERS, type: :request do

  describe "Test /user" do
    context "get all request" do
      before :all do
        get '/user'
      end

      it 'returns users' do
        expect(response).to have_http_status(:success)
      end


    end


    context "get all the users" do
      before :all do
        post '/user'
      end

      it 'returns all users' do
        expect(response).to have_http_status(:success)

      end
    end



    context "edit a user" do
      before :each do
        put '/user'
      end
      it "edits a user" do
        expect(response).to have_http_status(:success)
      end
    end

  end



end
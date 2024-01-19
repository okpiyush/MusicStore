require 'rails_helper'
require 'rack/test'
require_relative '../../app/api/base'
require 'factory_bot_rails'

FactoryBot.find_definitions

RSpec.describe V1::MUSIC, type: :request do
  describe "Testing /music" do
    context "get all music in the feed" do
      before :all do
        get '/music'
      end

      it "returns all music" do
        expect(response).to have_http_status(:success)
      end
    end

  end

end
require 'rails_helper'

RSpec.describe 'Users', type: :request do
  # If response status was correct
  describe 'GET /users' do
    it 'index works! have_http_status(200)' do
      get users_path
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /users/:id' do
    it 'show works! have_http_status(200)' do
      get user_path(1)
      expect(response).to have_http_status(200)
    end
  end
end

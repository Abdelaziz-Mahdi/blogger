require 'rails_helper'

RSpec.describe 'Users', type: :request do
  # If response status was correct.
  describe 'GET /users' do
    it 'Action index works! have_http_status(200)' do
      get users_path
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /users/:id' do
    it 'Action show works! have_http_status(200)' do
      get user_path(1)
      expect(response).to have_http_status(200)
    end
  end

  # If a correct template was rendered.
  describe 'GET /users' do
    it 'Action index works! render_template(:index)' do
      get users_path
      expect(response).to render_template(:index)
    end
  end

  describe 'GET /users/:id' do
    it 'Action show works! render_template(:show)' do
      get user_path(1)
      expect(response).to render_template(:show)
    end
  end

  # If the response body includes correct placeholder text.
  describe 'GET /users' do
    it 'Action index works! include("Here is a list of all users")' do
      get users_path
      expect(response.body).to include('Here is a list of all users')
    end
  end

  describe 'GET /users/:id' do
    it 'Action show works! include("Here is a profile for a given user")' do
      get user_path(1)
      expect(response.body).to include('Here is a profile for a given user')
    end
  end
end

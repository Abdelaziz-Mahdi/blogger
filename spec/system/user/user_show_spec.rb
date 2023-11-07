require 'rails_helper'

RSpec.describe 'Integration test for users show page', type: :system do
  before(:each) do
    driven_by(:rack_test)
    User.create(name: 'Tom', photo: 'https://ui-avatars.com/api/?name=Tom', bio: 'Teacher from Mexico.')
    Post.create(author: User.find_by(name: 'Tom'), title: 'Test 1', text: 'Post Text')
    Post.create(author: User.find_by(name: 'Tom'), title: 'Test 2', text: 'Post Text')
    Post.create(author: User.find_by(name: 'Tom'), title: 'Test 3', text: 'Post Text')
    Post.create(author: User.find_by(name: 'Tom'), title: 'Test 4', text: 'Post Text')
    visit user_path(User.find_by(name: 'Tom'))
  end

  describe 'check for the things in the page' do
    it 'has a profile picture for the user' do
      expect(page).to have_css("img[src*='https://ui-avatars.com/api/?name=Tom']")
    end

    it 'has a user name' do
      expect(page).to have_content('Tom')
    end

    it 'has a number of posts the user has written' do
      expect(page).to have_content('Number of posts: 4')
    end

    it 'has a bio for the user' do
      expect(page).to have_content('Teacher from Mexico.')
    end

    it 'has a list of user first 3 posts' do
      expect(page).to have_content('Test 2')
      expect(page).to have_content('Test 3')
      expect(page).to have_content('Test 4')
    end

    it 'has a link to the user posts' do
      expect(page).to have_link('See all posts')
    end
  end

  describe 'check clicking links' do
    it 'click a user post, it redirects to that post show page' do
      click_link('Test 2')
      expect(page).to have_current_path(user_post_path(User.find_by(name: 'Tom'), Post.find_by(title: 'Test 2')))
    end

    it 'will redirected to user Tom show page' do
      click_link('See all posts')
      expect(page).to have_current_path(user_posts_path(User.find_by(name: 'Tom')))
    end
  end

  describe 'check for other features in the page' do
    it 'has a button to add a new post' do
      expect(page).to have_link('Add New Post')
    end

    it 'click Add New Post, it redirect to new_user_post' do
      click_link('Add New Post')
      expect(page).to have_current_path(new_user_post_path(User.find_by(name: 'Tom')))
    end

    it 'After succefully add a new post, the number of posts for the user incressed by 1' do
      click_link('Add New Post')
      fill_in 'Title', with: 'Test 5'
      fill_in 'Text', with: 'Post Text'
      click_button('Post')
      expect(page).to have_content('Number of posts: 5')
      # clean up
      Post.find_by(title: 'Test 5').destroy
    end
  end
end

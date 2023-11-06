require 'rails_helper'

RSpec.describe 'Integration test for users posts index page', type: :system do
  before(:each) do
    driven_by(:rack_test)
    first_user = User.create(name: 'Tom', photo: 'https://ui-avatars.com/api/?name=Tom', bio: 'Teacher from Mexico.')
    Post.create(author: User.find_by(name: 'Tom'), title: 'Test 1', text: 'Post Text')
    second_post = Post.create(author: User.find_by(name: 'Tom'), title: 'Test 2', text: 'Post 2 Text')
    Post.create(author: User.find_by(name: 'Tom'), title: 'Test 3', text: 'Post 3 Text')
    Post.create(author: User.find_by(name: 'Tom'), title: 'Test 4', text: 'Post 4 Text')
    Comment.create(post: second_post, user: first_user, text: 'Hi Tom!')
    visit user_posts_path(User.find_by(name: 'Tom'))
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

    it 'has a list of user first 3 posts, posts tilte' do
      expect(page).to have_content('Test 2')
      expect(page).to have_content('Test 3')
      expect(page).to have_content('Test 4')
    end

    it 'has a list of user first 3 posts, posts text' do
      expect(page).to have_content('Post 2 Text')
      expect(page).to have_content('Post 3 Text')
      expect(page).to have_content('Post 4 Text')
    end

    it 'has the first comments on a post' do
      expect(page).to have_content('Hi Tom!')
    end

    it 'shows the number of comments on a post' do
      expect(page).to have_content('Comments: 1')
    end

    it 'shows the number of likes on a post' do
      expect(page).to have_content('Likes: 0')
    end

    it 'has a link to paginate to the next page' do
      expect(page).to have_link('Next')
    end
  end

  describe 'check clicking links' do
    it 'click a user post, it redirects to that post show page' do
      click_link('Test 2')
      expect(page).to have_current_path(user_post_path(User.find_by(name: 'Tom'), Post.find_by(title: 'Test 2')))
    end
  end
end

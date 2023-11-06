require 'rails_helper'

RSpec.describe 'Integration test for users posts show page', type: :system do
  before(:each) do
    driven_by(:rack_test)
    first_user = User.create(name: 'Tom', photo: 'https://ui-avatars.com/api/?name=Tom', bio: 'Teacher from Mexico.')
    Post.create(author: User.find_by(name: 'Tom'),title: 'Test 1',text: 'Post Text')
    second_post = Post.create(author: User.find_by(name: 'Tom'),title: 'Test 2',text: 'Post 2 Text')
    Post.create(author: User.find_by(name: 'Tom'),title: 'Test 3',text: 'Post 3 Text')
    Post.create(author: User.find_by(name: 'Tom'),title: 'Test 4',text: 'Post 4 Text')
    Comment.create(post: second_post, user: first_user, text: 'Hi Tom!' )
    visit user_post_path(User.find_by(name: 'Tom'),Post.find_by(title: 'Test 2'))
  end

  describe 'check for the things in the page' do

    it 'has the post title' do
      expect(page).to have_content('Test 2')
    end

    it 'has the post author' do
      expect(page).to have_content('Tom')
    end

    it 'has the number of comments on a post' do
      expect(page).to have_content('Comments: 1')
    end

    it 'has the number of likes on a post' do
      expect(page).to have_content('Likes: 0')
    end

    it 'has the post body text' do
      expect(page).to have_content('Post 2 Text')
    end

    it 'has the name of the user who wrote the comment' do
      expect(page).to have_content('Tom')
    end

    it 'has the text of the comment' do
      expect(page).to have_content('Hi Tom!')
    end
  end

  describe 'check for other features in the page' do

    it 'has a button to add a new comment' do
      expect(page).to have_button('Add a comment')
    end

    it 'has a button to like a post' do
      expect(page).to have_link('Like')
    end

    it 'show a form to add a new comment after click add a comment' do 
      click_button('Add a comment')
      expect(page).to have_link('Comment')
    end

    it 'add a new comment after click comment' do 
      click_button('Add a comment')
      fill_in('comment[text]', with: 'Test comment')
      click_button('Comment')
      expect(page).to have_content('Test comment')
      # clean up
      Comment.find_by(text: 'Test comment').destroy
    end
  end
end

require 'rails_helper'
RSpec.describe 'Integration test for users index', type: :system do
  before(:each) do
    driven_by(:rack_test)
    User.create(name: 'Tom', photo: 'https://ui-avatars.com/api/?name=Tom', bio: 'Teacher from Mexico.')
    User.create(name: 'Lilly', photo: 'https://ui-avatars.com/api/?name=Li', bio: 'Teacher from Poland.')
    Post.create(author: User.find_by(name: 'Tom'),title: 'Test',text: 'Post Text')
    visit root_path
  end
  describe 'check for the things in the page' do
    it 'has a list of users' do
      expect(page).to have_content('Tom')
      expect(page).to have_content('Lilly')
    end
    it 'has a profile picture for each user' do
      expect(page).to have_css("img[src*='https://ui-avatars.com/api/?name=Tom']")
      expect(page).to have_css("img[src*='https://ui-avatars.com/api/?name=Li']")
    end
    it 'has a number of posts each user has written' do
        expect(page).to have_content('Number of posts: 1')
        expect(page).to have_content('Number of posts: 0')
      end
    end
    describe 'check clicking links' do
      it 'will redirected to user Tom show page' do
        click_link('Tom')
        expect(page).to have_current_path(user_path(User.find_by(name: 'Tom')))
    end
    it 'will redirected to user Lilly show page' do
        click_link('Lilly')
        expect(page).to have_current_path(user_path(User.find_by(name: 'Lilly')))
      end
    end
  end
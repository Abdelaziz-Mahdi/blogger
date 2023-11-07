require 'rails_helper'
RSpec.describe 'Integration test for users index', type: :system do
  before(:each) do
    driven_by(:rack_test)
    User.create(name: 'Tom', photo: 'https://ui-avatars.com/api/?name=Tom', bio: 'Teacher from Mexico.')
    User.create(name: 'Lilly', photo: 'https://ui-avatars.com/api/?name=Li', bio: 'Teacher from Poland.')
    Post.create(author: User.find_by(name: 'Tom'),title: 'Test',text: 'Post Text')
    visit root_path
  end
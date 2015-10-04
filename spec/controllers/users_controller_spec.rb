require 'spec_helper'

RSpec.describe UsersController do
  describe 'GET index' do
    it 'returns all the users'
  end

  describe 'GET show' do
    it 'shows a specific user'
  end

  describe 'GET Edit' do
    it 'returns the user you are about to edit'
  end

  describe 'POST update' do
    before(:each) { sign_in :user, create(:user, role_ids: [1]) }
    it 'updates the user' do
      user = create(:user)
      post :update, {
             id: user.id,
             user: {
               name: 'hi there',
             }
           }
      expect(User.find(user.id).name).to eq('hi there')
    end

    it 'does not allow setting old roles' do
      user = create(:user)
      post :update, {
             id: user.id,
             user: {
               role_ids: [1, 2, 3, 4, 5],
             }
           }
      expect(User.find(user.id).role_ids.sort).to eq([1, 2, 4].sort)
    end
  end
end

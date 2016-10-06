require 'spec_helper'

RSpec.describe User do
  it 'validates the name is unique' do
    create(:user, name: 'joe')
    expect(build(:user, name: 'joe')).to be_invalid
  end

  it 'will default the role to [3] if none is provided' do
    user = create(:user)
    expect(user.role_ids).to eq([3])
  end

  describe '#make_all_members' do
    before(:each) {
      @user = create(:user, name: 'Alex', role_ids: [2, 3])
      @admin_user = create(:user, name: 'Connor', role_ids: [1, 2, 3])
    }

    it 'removes all non-3 roles if you do not have role 1' do
      expect(@user.role_ids).to eq([2,3])
      expect(@admin_user.role_ids).to eq([1, 2, 3])
      User.make_all_members
      expect(@user.reload.role_ids).to eq([4])
      expect(@admin_user.reload.role_ids).to eq([1, 2, 3])
    end
  end

  describe '#role?' do
    it 'checks if a role is included' do
      user = create(:user, name: 'Adam', role_ids: [1])
      expect(user.role?("Admin")).to be_truthy
    end
  end
end

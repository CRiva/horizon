require 'spec_helper'

describe User do
  before(:each) { User.destroy_all }
  after(:each) { User.destroy_all }

  it 'validates the name is unique' do
    expect(User.new({
                      name: 'Connor',
                      password: 'testpassword',
                      email: 'fake@fake.com'
                    })).to be_valid
    User.create!({
                   name: 'Connor',
                   password: 'testpassword',
                   email: 'fake@fake.com'
                 })
    expect(User.new({
                      name: 'Connor',
                      password: 'testpassword',
                      email: 'fake@fake.com'
                    })).to be_invalid
  end

  it 'will default the role to [3] if none is provided' do
    user = User.create!({
                          name: 'Alex',
                          password: 'testpassword',
                          email: 'fake@fake.com'
                        })
    expect(user.role_ids).to eq([3])
  end

  describe '#make_all_members' do
    before(:each) {
      @user = User.create!({
                             name: 'Alex',
                             password: 'testpassword',
                             email: 'fake@fake.com',
                             role_ids: [2, 3]
                           })
      @admin_user = User.create!({
                                   name: 'Connor',
                                   password: 'testpassword',
                                   email: 'fake2@fake.com',
                                   role_ids: [1, 2, 3]
                                 })
    }

    it 'removes all non-3 roles if you do not have role 1' do
      expect(@user.role_ids).to eq([2,3])
      expect(@admin_user.role_ids).to eq([1, 2, 3])
      User.make_all_members
      expect(@user.reload.role_ids).to eq([3])
      expect(@admin_user.reload.role_ids).to eq([1, 2, 3])
    end
  end

  describe '#role?' do
    it 'checks if a role is included' do
      Role.create({ name: "Admin" })
      user = User.create!({
                             name: 'Alex',
                             password: 'testpassword',
                             email: 'fake@fake.com',
                             role_ids: [1]
                           })
      expect(user.role?("Admin")).to be_truthy
    end
  end
end

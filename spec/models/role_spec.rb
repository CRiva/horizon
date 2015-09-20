require 'spec_helper'

describe Role do
  it 'represents a users role' do
    expect(Role.new({ name: "Admin" })).to be_valid
  end
end

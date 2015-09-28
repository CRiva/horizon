require 'spec_helper'

RSpec.describe Comment do
  it 'must have a name and body' do
    expect(Comment.new).to be_invalid
    expect(Comment.new(name: 'Jim', body: 'Wow this rocks!')).to be_valid
  end
end

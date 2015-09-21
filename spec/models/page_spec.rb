require 'spec_helper'

RSpec.describe Page do
  it 'must have a unique name' do
    expect(Page.new).to be_invalid
    expect(Page.new({name: "Sports"})).to be_valid
    Page.create!({name: "Sports"})
    expect(Page.new({name: 'Sports'})).to be_invalid
  end
end

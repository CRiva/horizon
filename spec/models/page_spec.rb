require 'spec_helper'

describe Page do
  after(:each) { Page.destroy_all }
  it 'must have a unique name' do
    expect(Page.new).to be_invalid
    expect(Page.new({name: "Sports"})).to be_valid
    Page.create!({name: "Sports"})
    expect(Page.new({name: 'Sports'})).to be_invalid
  end
end

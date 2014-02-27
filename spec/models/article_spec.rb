require 'spec_helper'

describe Article do
  describe "creation" do
    it "should be invaild without paramaters." do
      a = Article.new
      a.should_not be_valid
    end
    it "should be valid with valid params" do
      a = Article.new({title: "Test title", body: "Test body.", page: 1, author_name: "Tester McTest"})
      a.should be_valid
    end
  end
  describe "default values" do
    before(:each) do
      @article = Article.new({title: "Test title",
                               body: "Testbody.",
                               page: 1,
                               author_name: "Tester"})
    end
    it "should have useful starting values" do
      @article.published.should be_false
      @article.aasm_state.should == "new"
      @article.impressions_count.should == 0
    end
  end

  it "should not allow duplicate titles" do
    a = Article.new({title: "Test title", body: "Test body.", page: 1, author_name: "Tester McTest"})
    a.save!
    b = Article.new({title: "Test title", body: "Test body.", page: 1, author_name: "Tester McTest"})
    b.should_not be_valid
  end


end

require 'spec_helper'

RSpec.describe Article do
  describe 'validations' do
    it 'requires be invalid without params' do
      article = Article.new
      expect(article).to be_invalid
    end
  end

  describe 'with valid article' do
    let (:article) { build(:article) }

    it 'should set defaults' do
      expect(article.published).to be_truthy
      expect(article.impressions_count).to eq(0)
    end
  end

  describe 'with a published and unpublished article' do
    before(:each) {
      create(:article, title: 'Monkey', author_name: 'Mike', published: false)
      create(:article, title: 'Alligator', author_name: 'Jim', published: true)
      create(:article, title: 'French Press', author_name: 'Megan', published: true)
    }

    it 'will only show published articles in the published scope' do
      expect(Article.published.map(&:title)).to eq(['Alligator', 'French Press'])
    end

    it 'must have unique titles' do
      article = Article.new({
                    title: 'Monkey',
                    body: 'Chicken',
                    page: 1,
                    author_name: 'Mike',
                  })
      expect(article).to be_invalid
    end

    describe '#search' do
      it 'can search titles' do
        searched_articles = Article.search("French Press")
        expect(searched_articles.map(&:title)).to eq(["French Press"])
      end

      it 'can search authors' do
        searched_articles = Article.search("Jim")
        expect(searched_articles.map(&:title)).to eq(['Alligator'])
      end

      it 'will not search unpublished articles' do
        searched_articles = Article.search("Monkey")
        expect(searched_articles.map(&:title)).to eq([])
      end
    end

    describe '#readtime' do
      it 'estimates the readtime based on word count' do
        article =  Article.new({ body: "hello" })
        expect(article.read_time).to eq('Time to read: less than a minute')
        article.body = "word " * 150
        expect(article.read_time).to eq('Time to read: 1 minutes')
        article.body = "word " * 300
        expect(article.read_time).to eq('Time to read: 2 minutes')
      end
    end

    describe '#page_name' do
      it 'finds the name of the page the article is from' do
        page = Page.create!({ name: 'Sports' })
        Article.first.update_attribute('page', page.id)
        expect(Article.first.page_name).to eq('Sports')
      end
    end
  end
end

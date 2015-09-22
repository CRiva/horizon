require 'spec_helper'

RSpec.describe ArticlesController do
  describe 'GET index' do
    describe '.html' do
      it 'renders the index template and sets @articles' do
        get :index
        expect(assigns(:articles)).to eq([])
        expect(response.status).to eq(200)
        expect(response).to render_template("index")
      end

      describe 'with 20 articles' do
        before(:each) { 20.times { create(:article, published: true) } }

        it 'returns 10 articles in created at order' do
          expected_articles = Article.where(page: 1).order(created_at: :desc).limit(10)
          get :index, page_id: 1
          actual_articles = assigns(:articles)
          expect(actual_articles.map(&:title)).to eq(expected_articles.map(&:title))
        end

        it 'searches for articles' do
          create(:article, published: true, title: 'hello')
          get :index, search: 'hello'
          expect(assigns(:articles).map(&:title)).to eq(['hello'])
        end
      end
    end
  end

  describe 'GET show' do
    before(:each) { create(:article, title: 'Mexican Revolution') }

    it 'responds responds correctly' do
      get :show, id: 1
      expect(response.status).to eq(200)
      expect(response).to render_template("show")
    end

    it 'shows an article' do
      get :show, id: 1
      expect(assigns(:article).title).to eq('Mexican Revolution')
    end

    it 'marks the article viewed' do
      get :show, id: 1
      expect(assigns(:article).impressionist_count).to eq(1)
    end
  end

  describe 'GET new' do
    before(:each) { sign_in :user, create(:user, role_ids: [1]) }
    it 'returns an non-persisted article' do
      get :new
      expect(assigns(:article).persisted?).to be_falsey
    end

    it 'responds responds correctly' do
      get :new
      expect(response.status).to eq(200)
    end
  end

  describe 'POST create' do
    before(:each) { sign_in :user, create(:user, role_ids: [1]) }

    it 'will create a article' do
      params = { title: 'test',
                 body: 'test body',
                 page: 1,
                 published: true,
                 author_name: 'Adam',
                 due_date: Time.now
               }
      post :create, article: params
      expect(assigns(:article).attributes).to eq(Article.first.attributes)
    end
  end
end

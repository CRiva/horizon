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

    it 'creates an article' do
      post :create, article: attributes_for(:article)
      expect(assigns(:article)).to eq(Article.first)
    end

    it 'assigns the expected params' do
      params = attributes_for(:article)
      post :create, article: params
      attributes = assigns(:article).attributes
      assigned_attributes = attributes.select { |attr|
        params.keys.include?(attr.to_sym)
      }
      expect(assigned_attributes).to eq(params.stringify_keys)
    end

    it 'sets the expected defaults defaults' do
      defaults =  {
        "id" => 1,
        "photo_file_name" => nil,
        "photo_content_type" => nil,
        "photo_file_size" => nil,
        "photo_updated_at" => nil,
        "published" => true,
        "author_id" => nil,
        "due_date" => nil,
        "aasm_state" => "new",
        "impressions_count" => 0,
        "pdf_file_name" => nil,
        "pdf_content_type" => nil,
        "pdf_file_size" => nil,
        "pdf_updated_at" => nil
      }

      params = attributes_for(:article)
      post :create, article: params
      non_assigned = assigns(:article)
                 .attributes
                 .except(*attributes_for(:article).stringify_keys.keys)
                 .except("created_at", "updated_at")
      expect(non_assigned).to eq(defaults)
    end
  end

  describe 'POST update' do
    before(:each) { sign_in :user, create(:user, role_ids: [1]) }
    it 'updates the article' do
      create(:article)
      post :update, id: 1, article: { title: 'updated title' }
      expect(Article.first.title).to eq('updated title')
    end
  end
  describe "DELETE destroy" do
    it 'deletes the article'
  end
end

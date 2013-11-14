require 'test_helper' 
 
class ClubTest < ActionController::IntegrationTest
 
  def login()
  	visit '/users/sign_in'
  	fill_in 'user_email', with: 'bob@bob.com'
  	fill_in 'user_password', with: '1password'
  	click_button 'Sign in'
  end

  test "viewing articles" do
  	login
    visit '/articles/26'
    assert not(page.has_content?("Editing article"))
    assert page.has_content?('hey fans! this is unlikely text blah blah')
    visit '/articles/26/edit'
    assert page.has_content?("Editing article")
    assert page.has_content?('hey fans! this is unlikely text blah blah')
    # bummer!
    # TODO: Adam, please get us some default data and put it in a rake task
    # I was hoping db:migrate or db:test:prepare would put in the necessary
    # data. It was not to be.
    # can't do this without fixtures for pages and articles_pages
    #fill_in 'article_body', with: 'this is my new article body'
    #click_button 'Update Article'
    #assert not(page.has_content?("Editing article")) 
    #assert page.has_content("this is my new article body")
  end
 
end
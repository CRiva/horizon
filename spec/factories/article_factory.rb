FactoryGirl.define do
  factory :article do
    sequence(:title) { |n| "article#{n}"}
    body 'This is the body'
    author_name 'Connor'
    page 1
  end
end

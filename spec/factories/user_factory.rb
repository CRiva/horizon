FactoryGirl.define do
  factory :user do
    name 'test'
    email { "#{name}@example.com" }
    password 'testpassword'
  end
end

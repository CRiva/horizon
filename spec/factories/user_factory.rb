FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "Joe#{n}" }
    email { "#{name}@example.com" }
    password 'testpassword'
  end
end

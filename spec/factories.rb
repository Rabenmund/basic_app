FactoryGirl.define do
  factory :user, class: User do
    sequence(:name)           { |n| "TestUser#{n}"}
    email                     { "#{name}@example.com".downcase }
    sequence(:nickname)       { |n| "TestAlias#{n}"}
    password                  "password"
    password_confirmation     { "#{password}" }
  end
end
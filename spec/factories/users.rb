# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do |f|
    f.email "user@site.com"
    f.password "password"
    f.password_confirmation "password"

  end
end

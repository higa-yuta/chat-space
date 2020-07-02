FactoryBot.define do

  factory :user do
    sequence(:id) { |n| n }
    name {'test'}
    email {Faker::Internet.email}
    password {'1234567'}
    password_confirmation {'1234567'}
  end
end
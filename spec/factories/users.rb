FactoryBot.define do

  factory :user do
    name {'test'}
    email {'test@gmail.com'}
    password {'1234567'}
    password_confirmation {'1234567'}
  end
end
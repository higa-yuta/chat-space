FactoryBot.define do
  factory :group do
    sequence(:id) { |n| n }
    name {Faker::Name.initials(number: 10)}
  end
end
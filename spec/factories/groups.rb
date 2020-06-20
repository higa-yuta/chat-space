FactoryBot.define do
  factory :group do
    sequence(:id) {|n| n}
    name {Faker::Team.name}
  end
end
FactoryBot.define do
  factory :message do
    sequence(:id) {|n| n}
    text {Faker::Lorem.sentence}
    image {File.open("#{Rails.root}/spec/fixures/test.jpeg")}
    user
    group
  end
end
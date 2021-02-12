FactoryBot.define do
  factory :user do
    username              { Faker::Name.male_first_name }
    sex                   { :male }
    ages                  { :twenties }
    favorite              { 'ポケットモンスター' }
    password              { 'password' }
    password_confirmation { 'password' }
    sequence(:email)      { |n| 'app_tester#{n}@example.com' }
  end

  factory :user1, class: User do
    username              { 'user1' }
    sex                   { :female }
    ages                  { :teenagers }
    favorite              { 'ドラゴンクエスト' }
    password              { 'user1password' }
    password_confirmation { 'user1password' }
    sequence(:email)      { 'rspec_user1@example.com' }
  end

  factory :user2, class: User do
    username              { 'user2' }
    sex                   { :another }
    ages                  { :thirties }
    favorite              { 'ダービースタリオン' }
    password              { 'user2password' }
    password_confirmation { 'user2password' }
    sequence(:email)      { 'rspec_user2@example.com' }
  end
end
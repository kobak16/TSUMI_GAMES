FactoryBot.define do
  factory :game do
    title   { Faker::Game.title }
    machine { :ps4 }
    genre   { :rpg }
    association :user
  end

  factory :game1, class: Game do
    title   { 'ウイニングポスト9' }
    machine { :switch }
    genre   { :adventure }
    association :user, factory: :user1
  end

  factory :game2, class: Game do
    title   { 'ダービースタリオン' }
    machine { :ps4 }
    genre   { :action }
  end
end

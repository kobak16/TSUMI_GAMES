class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :games, dependent: :destroy
  has_many :likes
  has_many :following_relationships, foreign_key: "follower_id", class_name: "Relationship",  dependent: :destroy
  has_many :followings, through: :following_relationships
  has_many :follower_relationships, foreign_key: "following_id", class_name: "Relationship", dependent: :destroy
  has_many :followers, through: :follower_relationships

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  validates :username, presence: true
  validates :favorite, presence: false, length: { maximum: 50 }
  validates :sex, presence: true
  validates :ages, presence: true


  def following?(other_user)
    following_relationships.find_by(following_id: other_user.id)
  end

  def follow(other_user)
    following_relationships.create!(following_id: other_user.id)
  end

  def unfollow(other_user)
    following_relationships.find_by(following_id: other_user.id).destroy
  end

  def self.guest
    find_or_create_by!(username: 'ゲスト', email: 'guest_sample@example.com', 
                        sex: 'male', ages: 'twenties', favorite: 'ドラゴンクエスト') do |user|
      user.password = SecureRandom.urlsafe_base64
    end
  end

  enum sex: {
    male: 0,
    female: 1,
    another: 2
  }, _prefix: true

  enum ages: {
    under10: 0,
    teenagers: 1,
    twenties: 2,
    thirties: 3,
    forties: 4,
    fifties: 5,
    sixties: 6,
    over70: 7
  }, _prefix: true

end

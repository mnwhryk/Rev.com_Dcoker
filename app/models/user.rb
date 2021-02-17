class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :timeoutable

  has_many :comments, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :tags, dependent: :destroy

  # フォロー機能
  has_many :relationships
  has_many :followings, through: :relationships, source: :follow
  has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'follow_id'
  has_many :followers, through: :reverse_of_relationships, source: :user

  def follow(other_user)
    relationships.find_or_create_by(follow_id: other_user.id) unless self == other_user
  end

  def unfollow(other_user)
    relationship = relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship
  end

  def following?(other_user)
    followings.include?(other_user)
  end
  # ここまで/

  # 検索
  def self.search(search, user_or_comic, how_search)
    if user_or_comic == '1'
      if how_search == '1'
        User.where(['name LIKE ?', "%#{search}%"])
      elsif how_search == '2'
        User.where(['name LIKE ?', "%#{search}"])
      elsif how_search == '3'
        User.where(['name LIKE ?', "#{search}%"])
      elsif how_search == '4'
        User.where(['name LIKE ?', search.to_s])
      else
        User.all
      end
    end
  end

  # 画像投稿機能
  attachment :profile_image

  # バリデーション
  validates :name, presence: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: true, format: { with: VALID_EMAIL_REGEX }
  validates :introduction, length: { maximum: 300 }
end

class Review < ApplicationRecord
  belongs_to :user
  belongs_to :comic, primary_key: 'isbn'
  has_many :comments, dependent: :destroy

  # いいね機能
  has_many :likes, dependent: :destroy
  def liked_by?(user)
    likes.where(user_id: user.id).exists?
  end

  # バリデーション
  validates :comic_id, presence: true
  validates :user_id, presence: true
  validates :review, presence: true, length: { maximum: 300 }
  # 評価機能のバリデーション
  validates :rate, numericality: {
    less_than_or_equal_to: 5,
    greater_than_or_equal_to: 1
  }, presence: true
end

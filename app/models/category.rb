class Category < ApplicationRecord
  has_many :comics, dependent: :destroy

  validates :name, presence: true, uniqueness: true
end

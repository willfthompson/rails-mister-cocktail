class Cocktail < ApplicationRecord
  validates :name, uniqueness: true
  validates :name, presence: true
  has_many :doses, dependent: :destroy
  has_many :ingredients, through: :doses
  has_one_attached :photo
end

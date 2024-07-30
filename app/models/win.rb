class Win < ApplicationRecord
  belongs_to :user

  validates :title, presence: true, length: {minimum: 3, maximum: 30}
  validates :description, presence: true, length: {minimum: 3}
  validates :category, presence: true
end

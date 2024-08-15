class Win < ApplicationRecord
  belongs_to :user

  validates :title, presence: true, length: {minimum: 3, maximum: 30}
  validates :description, presence: true, length: {minimum: 3}
  validates :category, presence: true

  scope :in_range, -> (start_date, end_date) {
    where('accomplished_date >= ? AND accomplished_date <= ?', start_date, end_date)
  }

  scope :in_category, -> (categories) {
    where(category: categories)
  }
end

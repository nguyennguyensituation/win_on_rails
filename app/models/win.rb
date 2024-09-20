# frozen_string_literal: true

# The Win model represents an individual accomplishment belonging to a User.
class Win < ApplicationRecord
  belongs_to :user

  validates :title, presence: true, length: { minimum: 3, maximum: 100 }
  validates :description, presence: true, length: { minimum: 3 }
  validates :category, presence: true

  scope :in_range, lambda { |start_date, end_date|
    where('accomplished_date >= ? AND accomplished_date <= ?', start_date, end_date)
  }

  scope :in_category, ->(categories) { where(category: categories) }

  scope :contains_string, ->(string) { where('title LIKE ? OR description LIKE ?', "%#{string}%", "%#{string}%") }
end

# frozen_string_literal: true

# Create Wins table
class CreateWins < ActiveRecord::Migration[7.1]
  def change
    create_table :wins do |t|
      t.string :title
      t.text :description
      t.date :accomplished_date
      t.string :category
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end

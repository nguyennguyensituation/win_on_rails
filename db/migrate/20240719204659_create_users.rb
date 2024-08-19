# frozen_string_literal: true

# Create Users table
class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :username
      t.string :encrypted_password

      t.timestamps
    end
  end
end

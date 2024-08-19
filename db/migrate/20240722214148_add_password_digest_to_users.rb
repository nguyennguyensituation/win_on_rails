# frozen_string_literal: true

# Add password encryption to Users table
class AddPasswordDigestToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :password_digest, :string
    remove_column :users, :encrypted_password, :string
  end
end

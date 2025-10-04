# frozen_string_literal: true

class AddIsbnToProductFiles < ActiveRecord::Migration[7.1]
  def change
    add_column :product_files, :isbn, :string, limit: 20, null: true
    add_index :product_files, :isbn, where: "isbn IS NOT NULL"
  end
end

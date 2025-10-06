class AddIsbnToLinks < ActiveRecord::Migration[7.1]
  def change
    add_column :links, :isbn, :string
  end
end

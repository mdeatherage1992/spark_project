class AddListToListings < ActiveRecord::Migration[5.2]
  def change
    add_column :listings, :list, :jsonb
  end
end

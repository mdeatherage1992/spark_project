class CreateListings < ActiveRecord::Migration[5.2]
  def change
    create_table :listings do |t|
      t.string :spark_id
      t.string :listing_api_url

      t.timestamps
    end
  end
end

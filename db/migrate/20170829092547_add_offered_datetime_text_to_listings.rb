class AddOfferedDatetimeTextToListings < ActiveRecord::Migration[5.1]
  def change
    add_column :listings, :offered_datetime_text, :string
  end
end

class AddStatusToListing < ActiveRecord::Migration[5.1]
  def change
    add_column :listings, :status, :string, default: "open"
  end
end

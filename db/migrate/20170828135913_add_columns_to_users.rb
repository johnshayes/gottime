class AddColumnsToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :fb_profile, :string
    add_column :users, :phone_number, :string
    add_column :users, :location, :string
    add_column :users, :defaults_listing, :string
    add_column :users, :defaults_contact, :string
  end
end

class CreateBlacklists < ActiveRecord::Migration[5.1]
  def change
    create_table :blacklists do |t|
      t.references :user, foreign_key: true
      t.integer :friend_id, foreign_key: true

      t.timestamps
    end
  end
end

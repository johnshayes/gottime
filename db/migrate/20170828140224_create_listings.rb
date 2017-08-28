class CreateListings < ActiveRecord::Migration[5.1]
  def change
    create_table :listings do |t|
      t.datetime :offerred_datetime
      t.string :activity
      t.string :location
      t.string :comment
      t.string :friends_circle
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end

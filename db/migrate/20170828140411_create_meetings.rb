class CreateMeetings < ActiveRecord::Migration[5.1]
  def change
    create_table :meetings do |t|
      t.references :listing, foreign_key: true
      t.string :status

      t.timestamps
    end
  end
end

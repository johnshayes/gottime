class ChangeDefaultValueForMeetingStatus < ActiveRecord::Migration[5.1]
  def change
    change_column :meetings, :status, :string, default: "active"
  end
end

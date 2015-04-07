class CreateAttendees < ActiveRecord::Migration
  def change
    create_table :attendees do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.integer :event_id, null: false
      t.timestamps null: false
    end
  end
end

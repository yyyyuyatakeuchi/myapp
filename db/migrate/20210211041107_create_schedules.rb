class CreateSchedules < ActiveRecord::Migration[6.1]
  def change
    create_table :schedules do |t|
      t.integer :availability
      t.references :user, null: false, foreign_key: true
      t.datetime :start_time

      t.timestamps
    end
  end
end

class AddDatesCulumnToSchedule < ActiveRecord::Migration[6.1]
  def change
    add_column :schedules, :inDate, :string
  end
end

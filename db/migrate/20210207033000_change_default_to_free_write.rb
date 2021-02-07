class ChangeDefaultToFreeWrite < ActiveRecord::Migration[6.1]
  def change
    change_column :talent_profiles, :free_write, :text, default: ""
  end
end

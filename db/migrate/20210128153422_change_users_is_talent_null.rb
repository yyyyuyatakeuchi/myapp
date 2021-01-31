class ChangeUsersIsTalentNull < ActiveRecord::Migration[6.1]
  def up
    change_column :users, :isTalent, :boolean, null: true
  end

  def down
    change_column :users, :isTalent, :boolean, null: false
  end
end

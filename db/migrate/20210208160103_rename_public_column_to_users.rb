class RenamePublicColumnToUsers < ActiveRecord::Migration[6.1]
  def change
    rename_column :users, :public, :isPublic
  end
end

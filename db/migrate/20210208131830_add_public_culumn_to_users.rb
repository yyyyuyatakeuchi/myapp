class AddPublicCulumnToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :public, :boolean, default: false
  end
end

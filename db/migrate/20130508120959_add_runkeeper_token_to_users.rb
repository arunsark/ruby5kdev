class AddRunkeeperTokenToUsers < ActiveRecord::Migration
  def change
    add_column :users, :runkeeper_token, :string
  end
end

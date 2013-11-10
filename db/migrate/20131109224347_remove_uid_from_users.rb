class RemoveUidFromUsers < ActiveRecord::Migration
  def up
    remove_column :users, :uid 
    remove_column :users, :token 
  end

  def down
  	add_column :users, :uid 
    add_column :users, :token 
  end
end

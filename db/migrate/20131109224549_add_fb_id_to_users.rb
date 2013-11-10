class AddFbIdToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :twt_id, :integer
  	add_column :users, :fb_id, :integer
    add_column :users, :fb_access_token , :string
    add_column :users, :twt_access_token , :string
  end
end

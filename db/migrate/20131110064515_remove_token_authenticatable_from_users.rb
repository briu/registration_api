class RemoveTokenAuthenticatableFromUsers < ActiveRecord::Migration
  def up
  	remove_column :users, :token_authenticatable
  end

  def down

  end
end

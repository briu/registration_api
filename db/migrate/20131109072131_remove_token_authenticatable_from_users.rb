class RemoveTokenAuthenticatableFromUsers < ActiveRecord::Migration
  def up
    remove_column :users, :token_authenticatable, :string
  end

  def down
    add_column :users, :token_authenticatable, :string
  end
end

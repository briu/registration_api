class ChangeTwtIdInUsers < ActiveRecord::Migration
  def up
    change_column :users, :twt_id, :string
  end

  def down
    change_column :users, :twt_id, :integer
  end
end

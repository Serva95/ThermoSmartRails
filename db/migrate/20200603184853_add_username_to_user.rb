class AddUsernameToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, "username", :string, :limit => 64
  end
end

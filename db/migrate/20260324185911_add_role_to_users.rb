# db/migrate/..._add_role_to_users.rb
class AddRoleToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :role, :string, default: 'user', null: false
    add_index :users, :role
  end
end

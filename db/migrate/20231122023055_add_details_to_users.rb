class AddDetailsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :role, :string
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :age, :integer
    add_column :users, :contact_number, :string
    add_column :users, :address, :string
    add_column :users, :medical_history, :string
  end
end

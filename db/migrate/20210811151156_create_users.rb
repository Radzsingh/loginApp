class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :user_name, null: false
      t.string :encypted_password
      t.integer :login_attempts, default: 0

      t.timestamps
    end
    add_index :users, :user_name, unique: true
  end
end

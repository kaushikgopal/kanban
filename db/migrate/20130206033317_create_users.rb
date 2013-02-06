class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :preferred_name
      t.string :email
      t.string :twiki_name
      t.string :username

      t.timestamps
    end
  end
end

class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      #Do we want to include a Name field?
      #t.string :name
      t.string :username
      t.string :email
      t.string :password_digest

      t.timestamps
    end
  end
end

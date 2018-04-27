class CreateConcerts < ActiveRecord::Migration[5.1]
  def change
    create_table :concerts do |t|
      t.string :name
      t.datetime :start_time

      t.timestamps
    end
  end
end

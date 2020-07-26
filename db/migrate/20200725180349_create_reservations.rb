class CreateReservations < ActiveRecord::Migration[6.0]
  def change
    create_table :reservations do |t|
      t.string :res_name
      t.integer :party_size
      t.string :res_day
      t.string :res_time

      t.timestamps
    end
  end
end

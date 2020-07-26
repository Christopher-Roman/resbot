class CreateTabletops < ActiveRecord::Migration[6.0]
  def change
    create_table :tabletops do |t|
      t.integer :seats
      t.string :table_name

      t.timestamps
    end
  end
end

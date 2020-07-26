class AddTabletopToReservation < ActiveRecord::Migration[6.0]
  def change
  	add_column :reservations, :tabletops_id, :integer
  	add_index :reservations, :tabletops_id
  end
end

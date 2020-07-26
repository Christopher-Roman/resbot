class Tabletop < ApplicationRecord
	
  has_many :reservations

  validates_presence_of :seats

  validates_presence_of :seats

end

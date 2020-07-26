class Reservation < ApplicationRecord
	
	belongs_to :tabletop

	validates :res_name, presence: true,
						length: {minimum: 3}

	validates :party_size, presence: true

	validates :res_day, presence: true,
							length: {minimum: 3}

	validates :res_time, presence: true,
							length: {minimum: 3}

end

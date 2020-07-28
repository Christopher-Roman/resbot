class ReservationsController < ApplicationController
 
  skip_before_action :verify_authenticity_token

  def index
    @reservations = Reservation.order('res_day DESC')
  end
  
  def _new
    @reservation = Reservation.new
  end

  def create
    table_id = confirm_reservation_with(params[:res_day], params[:res_time], params[:party_size])
    if table_id
      @reservation = Reservation.new(res_name:params[:res_name], res_time:params[:res_time], party_size:params[:party_size], res_day:params[:res_day], tabletops_id:table_id)
      if @reservation.save
        redirect_to '/reservations', notice: "Reservation confirmed!"
      else
        redirect_to '/reservations', warning: "Error occured during booking process, please try again."
      end
    elsif !table_id
      redirect_to '/reservations', warning: "There are no tables available for the selected date and time."
    else
      redirect_to '/reservations', warning: "An error occurred after attempting to confirm reservation method"
    end
  end

  private 

  def reservation_params
    params.permit(:res_name, :res_time, :party_size, :res_day, :tabletops_id)
  end

  def res_list_by day, time
    occupied_tables = []
    reservations = Reservation.where(res_day: day, res_time: time)
    if reservations.length > 0
      reservations.each do |res|
        occupied_tables << res.tabletops_id
      end
      return occupied_tables
    else
      return nil
    end
  end

  def tabletops_that_meet_requested seats
    table_numbers = []
    tabletops = Tabletop.where("seats >= ?", seats)
    if tabletops.length > 0
      tabletops.each do |table|
        table_numbers << table.id
      end
      return table_numbers
    else
      return nil
    end
  end

  def confirm_reservation_with day, time, seats
    #Get all reservations tabletop IDs for specific date and time
    current_reservations = res_list_by(day, time)

    if !current_reservations
      compatable_tables = tabletops_that_meet_requested(seats)
      if !compatable_tables
        return nil
      else
        res_table_id = compatable_tables[0]
        return res_table_id
      end
    elsif current_reservations.length >= 10
      return nil
    else
     #Get all compatable tables based on the party size
      compatable_tables = tabletops_that_meet_requested(seats)
      table_options = compatable_tables.reject do |i|
        current_reservations.include?(i)
      end
      res_table_id = table_options[0]
      return res_table_id
    end
  end




  #   # No reservations booked during time/day
  #   if !current_reservations
  #     res_table_id = compatable_tables[0]
  #     return res_table_id
  #   # All tables are occupied during time/day
  #   elsif current_reservations.length >= 10
  #     return res_table_id
  #   # Remove occupied tables from table array
  #   else
  #     # No compatable tables after dupes removed
  #     if table_options === 0
  #       return res_table_id
  #     # Select first available table in table array
  #     else
  #       res_table_id = table_options[0]
  #       return res_table_id
  #     end
  #   end
  # end
  
end

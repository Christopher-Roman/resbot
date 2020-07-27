class ReservationsController < ApplicationController
 
  skip_before_action :verify_authenticity_token

  def index
    @reservations = Reservation.order('res_day DESC')
  end
  
  def new
    @reservation = Reservation.new
  end

  def create
    table_id = confirm_reservation_with(params[:res_day], params[:res_time], params[:party_size])
    puts table_id
    if table_id
      @reservation = Reservation.new(res_name:params[:res_name], res_time:params[:res_time], party_size:params[:party_size], res_day:params[:res_day], tabletops_id:table_id)
      if @reservation.save
        puts 'Reservation Created'
      else
        puts 'Something went wrong.'
      end
    elsif !table_id
      puts "There are no available tables for the selected time."
    else
      puts "An error occurred after attempting to confirm reservation method"
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
      puts table_numbers
      return table_numbers
    else
      return nil
    end
  end

  def confirm_reservation_with day, time, seats
    current_reservations = res_list_by(day, time)

    compatable_tables = tabletops_that_meet_requested(seats)

    res_table_id = nil

    if !current_reservations
      res_table_id = compatable_tables[0]
      return res_table_id
    elsif current_reservations.length >= 10
      return res_table_id
    else 

      table_options = compatable_tables.reject do |i|
        current_reservations.include?(i)
      end
      puts "====reject/inlude===="
      puts table_options
      puts "====reject/inlude===="
      # table_options = current_reservations + compatable_tables
      # table_options.uniq
      # puts "====after uniq===="
      # puts table_options
      # puts "====after uniq===="

      if table_options === 0
        return res_table_id
      else
        res_table_id = table_options[0]
        return res_table_id
      end
    end
  end

  # def confirm_reservation_with day, time, seats
  #   #Get all reservations tabletop IDs for specific date and time
  #   current_reservations = res_list_by(day, time)
  #   #Get all compatable tables based on the party size
  #   compatable_tables = tabletops_that_meet_requested(seats)
  #   #If res_list_by returns nil do
  #   table_options = nil
  #   if current_reservations === nil
  #     res_table_id = compatable_tables[0]
  #     return res_table_id
  #   #If there are 10 reservations for the date and time return error
  #   elsif current_reservations.length >= 10
  #     return "There are no available tables for the selected time and party size."
  #   else
  #     table_options = (current_reservations + compatable_tables - (current_reservations & compatable_tables))
  #   end
  #   if table_options != nil
  #     res_table_id = table_options[0]
  #   else
  #     return "There are no available tables for the selected time and party size."
  #   end
  #   return res_table_id
  # end
  
end

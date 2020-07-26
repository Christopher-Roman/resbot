class ReservationsController < ApplicationController
 
  skip_before_action :verify_authenticity_token

  def index
    @reservations = Reservation.order('res_day DESC')
    res_list_by("Sat", "7PM")
  end
  
  def new
    @reservation = Reservation.new
  end

  def create
    table_id = confirm_reservation_with(params[:res_day], params[:res_time], params[:party_size])
    if table_id
      @reservation = Reservation.new(res_name:params[:res_name], res_time:params[:res_time], party_size:params[:party_size], res_day:params[:res_day], tabletops_id:table_id)
      if @reservation.save
        puts 'Reservation Created'
      else
        puts 'Something went wrong.'
      end
    else
      puts "An error occurred after attempting to confirm reservation method"
    end
  end

  private 

  def reservation_params
    params.permit(:res_name, :res_time, :party_size, :res_day, :tabletops_id)
  end

  def res_list_by day, time
    reservations = Reservation.where(res_day: day, res_time: time)
    occupied_tables = []
    reservations.each do |res|
      occupied_tables << res.tabletops_id
    end
    return occupied_tables 
  end

  def tabletops_that_meet_requested seats
    tabletops = Tabletop.where("seats >= ?", seats)
    return tabletops
  end

  def confirm_reservation_with day, time, seats
    current_reservations = res_list_by(day, time)
    compatable_tables = tabletops_that_meet_requested(seats)
    if (current_reservations.length >= 10)
      puts "There are no available tables for the selected time and party size."
    else
      table_options = current_reservations.reject do |i|
        compatable_tables.include?(i)
      end
    end
    if table_options
      res_table_id = table_options[0]
    else
      puts "There are no available tables for the selected time and party size."
    end
    return res_table_id
  end
  
end

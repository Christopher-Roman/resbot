class TabletopsController < ApplicationController

  skip_before_action :verify_authenticity_token

  def index
    @tabletops = Tabletop.all
    puts @tabletops
  end
  
  def new
    @tabletop = Tabletop.new
  end

  def create
    @tabletop = Tabletop.new(tabletop_params)
    puts @tabletop[:table_name]
    if @tabletop.save
      puts 'Tabletop Created'
    else
      puts 'Something went wrong.'
    end
  end

  private 

  def tabletop_params
    params.permit(:seats, :table_name)
  end

end

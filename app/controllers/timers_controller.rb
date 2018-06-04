class TimersController < ApplicationController
  before_action :set_timer
  before_action :time_dif, only: [:index, :on_render]

  def index
  end

  def on_render
    if @timer.state == true
      render json: { state: @timer.state, time: @timer.time, updated_at: @timer.updated_at.to_f*1000, time_difference: @time_difference, falseTimestamp: @timer.falseTimestamp}
    else
      render json: {}
    end
  end

  def switch_on
    @timer.update(state: true)
    render json: { state: @timer.state, time: @timer.time }
  end
  def switch_off
    @timer.update(state: false, time: params[:callback_time].to_i, falseTimestamp: Time.new)
    render json: { state: @timer.state }
  end

  def increase_time
    render json: {  }
  end
  def decrease_time
    render json: {  }
  end
  
  private
    def set_timer
      @timer = Timer.find(1)
    end
    def time_dif
      if @timer.state == true
        @time_difference = @timer.time - ((Time.new - @timer.updated_at) / 1.second).round
      else
        @time_difference = @timer.time
      end
    end
end

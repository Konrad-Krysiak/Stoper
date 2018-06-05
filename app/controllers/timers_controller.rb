class TimersController < ApplicationController
  before_action :set_timer
  before_action :time_dif, only: [:index, :on_render]

  def index
  end 

  def on_render
    if @timer.state == true
      render json: { state: @timer.state, time: @timer.time, time_difference: @time_difference}
    else
      render json: { description: "Timer is turned off."}
    end
  end

  def UpToDate
    state = true? params[:state]
    if @timer.state != state
      render json: { changes_occurred: true, state: @timer.state, time: @timer.time}
    else
      render json: { changes_occurred: false }
    end
  end

  def switch_on
    @timer.update(state: true)
    render json: { state: @timer.state, time: @timer.time }
  end
  def switch_off
    @timer.update(state: false, time: params[:callback_time])
    render json: { state: @timer.state }
  end

  def true?(obj)
    obj.to_s == "true"
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

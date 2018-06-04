class TimersController < ApplicationController
  before_action :set_timer

  def index
  end

  def on_render
    render json: { state: @timer.state, time: @timer.time, updated_at: @timer.updated_at}
  end

  def switch_on
    @timer.update(state: true)
    render json: { state: @timer.state, time: @timer.time }
  end
  def switch_off
    @timer.update(state: false, time: params[:callback_time])
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
end

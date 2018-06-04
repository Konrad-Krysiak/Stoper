class AddFalseTImestampToTimers < ActiveRecord::Migration
  def change
    add_column :timers, :falseTimestamp, :datetime
  end
end

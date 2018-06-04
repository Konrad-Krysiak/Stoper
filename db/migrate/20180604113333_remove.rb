class Remove < ActiveRecord::Migration
  def change
  	remove_column :timers, :falseTimestamp
  end
end

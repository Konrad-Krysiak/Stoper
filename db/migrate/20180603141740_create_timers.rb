class CreateTimers < ActiveRecord::Migration
  def change
    create_table :timers do |t|
      t.integer :time
      t.boolean :state

      t.timestamps null: false
    end
  end
end

class AddCapacity < ActiveRecord::Migration
  def change
    change_table :groups do |t|
      t.integer :capacity
      t.integer :extra_capacity
  end
  end
end

class AddSeasonName < ActiveRecord::Migration
  def change
    change_table :seasons do |t|
      t.string :name
    end
  end
end

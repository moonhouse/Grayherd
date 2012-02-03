class CreateSeasons < ActiveRecord::Migration
  def change
    create_table :seasons do |t|
      t.date :start
      t.date :end
      t.date :deadline

      t.timestamps
    end
  end
end

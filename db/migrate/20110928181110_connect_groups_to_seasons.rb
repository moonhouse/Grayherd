class ConnectGroupsToSeasons < ActiveRecord::Migration
  def change
    change_table :groups do |t|
      t.references :season
    end
    change_table :registrations do |t|
      t.references :season
      t.references :person
      t.references :group
    end
  end
end

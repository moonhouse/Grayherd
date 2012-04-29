class AddExtraInfoToRegistration < ActiveRecord::Migration
  def change
    change_table :registrations do |t|
      t.string :extra_info
  end
  end
end

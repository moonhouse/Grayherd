class CreateGroupApplications < ActiveRecord::Migration
  def change
    create_table :group_applications do |t|
      t.string :name
      t.string :email
      t.string :address
      t.integer :zipcode
      t.string :ssn

      t.timestamps
    end
  end
end

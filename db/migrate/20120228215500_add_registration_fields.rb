class AddRegistrationFields < ActiveRecord::Migration
  def change
    change_table :registrations do |t|
      t.string :name
      t.string :email
      t.string :address
      t.integer :zipcode
      t.string :city
      t.string :ssn
      t.string :mobile_phone
      t.string :allergies
      t.string :parent_name
      t.string :parent_email
      t.string :parent_phone
  end
  end
end

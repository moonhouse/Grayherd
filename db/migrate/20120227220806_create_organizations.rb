class CreateOrganizations < ActiveRecord::Migration
  def change
    create_table :organizations do |t|
      t.string :name
      t.string :username
      t.string :password

      t.timestamps
    end

      change_table :seasons do |t|
    t.references :organization
  end
  end

end

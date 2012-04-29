class AddSubdomain < ActiveRecord::Migration
  def change
    change_table :organizations do |t|
      t.string :subdomain
    end
  end
end

class AddMailFields < ActiveRecord::Migration
  def change
    change_table :groups do |t|
      t.text :mail_message
      t.text :sender_address
      t.string :sender_email
  end
  end
end

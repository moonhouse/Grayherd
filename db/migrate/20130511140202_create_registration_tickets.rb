class CreateRegistrationTickets < ActiveRecord::Migration
  def self.up
    create_table(:registration_tickets) do |t|
      t.references :group
      t.string :session_id
      t.timestamps
    end

  end

  def self.down
    drop_table :registration_tickets
  end
end

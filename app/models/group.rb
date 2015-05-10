class Group < ActiveRecord::Base
  has_many :registrations
  has_many :registration_tickets
  belongs_to :season

  def outstanding_tickets
    #only count valid tickets
    registration_tickets.where("updated_at > ?", DateTime.now - RegistrationTicket::TICKET_TIMEOUT.minutes).count
  end

  def remaining_tickets
    diff = remaining_seats - outstanding_tickets
    diff < 0 ? 0 : diff
  end

  def remaining_seats
    if remaining_seats?
     capacity - registrations.count
    else
      0
    end
  end

  def remaining_seats?
    registrations.count < capacity
  end

  def remaining_reserve_seats?
    extra_capacity_num = extra_capacity.nil? ? 0 : extra_capacity # temp fix since
    !remaining_seats? && (extra_capacity_num + capacity) > registrations.count
  end

  def remaining_reserve_seats
    extra_capacity_num = extra_capacity.nil? ? 0 : extra_capacity
    if remaining_reserve_seats?
      (extra_capacity_num + capacity) - registrations.count
    else
      if remaining_seats?
        false
      else
        0
      end
    end
  end

  def no_seats_left?
    !(remaining_seats? || remaining_reserve_seats?)
  end

  def get_ticket(session_id)
    puts "Get registration ticket for session id #{session_id}"
    rts = RegistrationTicket.where("session_id = ? AND group_id = ?", session_id, id)
    if rts.size > 0
      puts "Found existing ticket"
      rt = rts.first
      if rt.still_valid?
        puts "RT valid"
        # save registration
      else
        puts "RT invalid"
        # renegotiate registration ticket
        puts rt.renegotiate
        puts "RT valid: #{rt.still_valid?}"
      end
      rt
    else
      puts "Created new ticket"
      rt = RegistrationTicket.new({session_id: session_id})
      rt.group_id = id
      rt.save
      rt
    end
  end

  def as_json(options={})
    { name: name,
      capacity: capacity,
      description: description,
      extra_capacity: extra_capacity,
      id: id,
      mail_message: mail_message,
      season_id: season_id,
      sender_address: sender_address,
      sender_email: sender_email,
      url: url,
      remaining_seats: remaining_seats,
      remaining_reserve_seats: remaining_reserve_seats,
      registrations: registrations
    }
  end
end

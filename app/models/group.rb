class Group < ActiveRecord::Base
  has_many :registrations
  belongs_to :season

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

  def as_json(options={})
    { :name => name,
      capacity: capacity,
      description: description,
      extra_capacity: extra_capacity,
      id: id,
      mail_message: mail_message,
      name: name,
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

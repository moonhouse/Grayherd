class Group < ActiveRecord::Base
  has_many :registrations
  belongs_to :season

  def remaining_seats
     capacity - registrations.count
  end

  def remaining_seats?
    registrations.count < capacity
  end

  def remaining_reserve_seats?
    !remaining_seats? && (extra_capacity + capacity) > registrations.count
  end

  def remaining_reserve_seats
    if remaining_reserve_seats?
      (extra_capacity + capacity) - registrations.count
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
end

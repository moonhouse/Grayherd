# encoding: utf-8

class Registration < ActiveRecord::Base
  belongs_to :group
  validates :name, :length => { :minimum => 5 }
  validates :address, :length => { :minimum => 5 }
  validates :city, :length => { :minimum => 3 }
  validates :parent_name, :length => { :minimum => 5 }
  validates :parent_email, :presence => true,
                     :length => {:minimum => 3, :maximum => 254},
                     :format => {:with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i}
    validates :parent_phone, :presence => true,
                     :length => {:minimum => 5, :maximum => 20},
                     :format => {:with => /^(\+)?[0-9\ \-\(\)]{5,19}$/i}

  #validates :parent_email
  validates :ssn, :uniqueness => true
  validate :validate_ssn
  validate :seats_left

  def passes_luhn_check?(str)
    sum = 0
    numbers = str.split(//).map(&:to_i)
    numbers.each_with_index do |n, i|
      n *= 2 if i.even?
      n -= 9 if n >= 10
      sum += n
    end
    sum % 10 == 0
  end

  def seats_left
    if group.remaining_seats > 0 or group.remaining_reserve_seats > 0
      puts "Seats left"
    else
      errors.add(:group, :fully_booked)
    end
  end

  def validate_ssn
    # Kontrollera antal siffror i personnummret.
    dssn = ssn.gsub(/[^0-9]/, "")

    if not (dssn.size == 10 or dssn.size == 12)
      errors.add(:ssn, :wrong_format)
    end

    if dssn.size == 12
      dssn = dssn.slice(2,10)
      puts dssn
    end

    # Räkna ut kontrollsiffran
    errors.add(:ssn, :wrong_checksum) unless passes_luhn_check?(dssn)
    begin
      DateTime.strptime('19'+dssn.slice(0,6), '%Y%m%d')
rescue
    errors.add(:ssn, :wrong_date)
    end


  end



end

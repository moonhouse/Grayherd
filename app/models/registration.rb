# encoding: utf-8

class Registration < ActiveRecord::Base
  attr_accessor :registration_ticket

  belongs_to :group
  validate :valid_registration_ticket
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

  before_validation(:on => :create) do
    self.ssn = ssn.gsub(/[^0-9]/, "") if attribute_present?("ssn")
    if ssn.size == 10
      self.ssn = "19"+self.ssn
    end
  end

  def valid_registration_ticket
    puts "VRD #{registration_ticket}"
    if registration_ticket.still_valid?
      puts "Valid ticket"
    else
      errors.add(:group, :invalid_ticket)
    end
  end

  def passes_luhn_check?(str)
    if str.size == 12
      str = str.slice(2,10)
    end
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
    dssn = ssn

    if not dssn.size == 12
      errors.add(:ssn, :wrong_format)
    end

    # Räkna ut kontrollsiffran
    errors.add(:ssn, :wrong_checksum) unless passes_luhn_check?(dssn)
    begin
      DateTime.strptime(dssn.slice(0,8), '%Y%m%d')
    rescue
      errors.add(:ssn, :wrong_date)
    end


  end

  def row_array
    [id, created_at, updated_at, name, email, address, zipcode, city, ssn, mobile_phone, allergies, parent_name, parent_email, parent_phone, extra_info]
  end


end

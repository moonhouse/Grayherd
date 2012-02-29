# encoding: utf-8

class Registration < ActiveRecord::Base
  belongs_to :group
  validates :name, :length => { :minimum => 5 }
  validates :address, :length => { :minimum => 5 }
  validates :city, :length => { :minimum => 3 }
  validates :parent_name, :length => { :minimum => 5 }
  #validates :parent_email
  validate :validate_ssn

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

  def validate_ssn
    # Kontrollera antal siffror i personnummret.
    dssn = ssn.gsub(/[^0-9]/, "")

    if not (dssn.size == 10 or dssn.size == 12)
      errors.add(:ssn, " innehåller fel antal siffror. (ÅÅÅÅMMDDXXXX)")
    end

    if dssn.size == 12
      dssn = dssn.slice(2,10)
      puts dssn
    end

    # Räkna ut kontrollsiffran
    errors.add(:ssn, 'Personnumret måste vara riktigt.') unless passes_luhn_check?(dssn)
  end



end

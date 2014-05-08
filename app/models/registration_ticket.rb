# encoding: utf-8

class RegistrationTicket < ActiveRecord::Base
  belongs_to :group
  attr_accessible :session_id
  TICKET_TIMEOUT = 10

  def timeout_at
    updated_at + TICKET_TIMEOUT.minutes
  end

  def javascript_version
    timeout_at.strftime("%Y, %m-1, %e, %H, %M, %S")
  end

  def still_valid?
    DateTime.now < timeout_at
  end

  def renegotiate
    if group.remaining_tickets > 0
      self.updated_at = DateTime.now
      self.save
    else
      false
    end
  end

end

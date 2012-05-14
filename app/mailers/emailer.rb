# encoding: UTF-8
class Emailer < ActionMailer::Base
  default from: "welcome@greyherd.com"

  def confirmation_email(registration)
    @registration = registration
    mail(:from => registration.group.sender_email ,:to => registration.parent_email, :subject => "Anmälan mottagen #{registration.group.name}")
  end
end

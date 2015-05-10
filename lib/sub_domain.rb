class SubDomain
  def self.matches?(request)
    case request.subdomain
    when 'greyherd','www', '', nil
      false
    else
      true
    end
  end
end
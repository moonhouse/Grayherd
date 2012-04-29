class SubDomainController < ApplicationController
  before_filter :get_organization_from_subdomain

  private

  def get_organization_from_subdomain
    case request.subdomain
    when 'www', '', nil
      false
    else
      @organization = Organization.find_by_subdomain!(request.subdomain)
    end
  end
end
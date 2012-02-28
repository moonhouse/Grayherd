class OrganizationsController < ApplicationController
  def index
    @organizations = Organization.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @organizations }
    end
  end

  def show
     @organization = Organization.find(params[:id])
     p @organization.seasons

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @organization }
    end
  end

end

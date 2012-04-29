class OrganizationsController < SubDomainController
  def index
    @organizations = Organization.all

    respond_to do |format|
      format.html # index.html.zurb.erb
      format.json { render json: @organizations }
    end
  end

  def show

     @organization = @organization || Organization.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @organization }
    end
  end

end

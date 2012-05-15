# encoding: UTF-8
class RegistrationsController < ApplicationController
  # GET /registrations
  # GET /registrations.json
  def index
    @registrations = Registration.all

    respond_to do |format|
      format.html # index.html.zurb.erb
      #format.json { render json: @registrations }
    end
  end

  # GET /registrations/1
  # GET /registrations/1.json
  def show
    @registration = Registration.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      #format.json { render json: @registration }
    end
  end

  # GET /registrations/new
  # GET /registrations/new.json
  def new
    @registration = Registration.new
    @registration.group_id = params[:group].to_i unless params[:group].empty?

    respond_to do |format|
      format.html # new.html.erb
      #format.json { render json: @registration }
    end
  end

  # GET /registrations/1/edit
  def edit
    @registration = Registration.find(params[:id])
  end

  # POST /registrations
  # POST /registrations.json
  def create
    @registration = Registration.new(params[:registration])

    respond_to do |format|
      if @registration.save
        if @registration.group.remaining_seats == 0
          notice = 'Du är på reservplats i gruppen eftersom alla ordinarie platser var tagna.'
          Emailer.reserve_email(@registration).deliver
          @reserve = true
        else
          notice = 'Din anmälan är mottagen.'
          Emailer.confirmation_email(@registration).deliver
          @reserve = false
        end
        format.html { redirect_to @registration, notice: notice }
        #format.json { render json: @registration, status: :created, location: @registration }
      else
        format.html { render action: "new" }
        #format.json { render json: @registration.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /registrations/1
  # PUT /registrations/1.json
  #def update
  #  @registration = Registration.find(params[:id])
  #
  #  respond_to do |format|
  #    if @registration.update_attributes(params[:registration])
  #      format.html { redirect_to @registration, notice: 'Registration was successfully updated.' }
  #      #format.json { head :ok }
  #    else
  #      format.html { render action: "edit" }
  #      #format.json { render json: @registration.errors, status: :unprocessable_entity }
  #    end
  #  end
  #end

  # DELETE /registrations/1
  # DELETE /registrations/1.json
  #def destroy
  #  @registration = Registration.find(params[:id])
  #  @registration.destroy
  #
  #  respond_to do |format|
  #    format.html { redirect_to registrations_url }
  #    format.json { head :ok }
  #  end
  #end
end

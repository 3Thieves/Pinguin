require 'date'
class LocationsController < ApplicationController
  before_action :set_location, only: [:show, :edit, :update, :destroy]
  before_action :check_admin, only: [:index, :new, :edit, :destroy]
  # GET /locations
  # GET /locations.json
  def index
    if params[:spot]
	@lat_lng = Geocoder.search(params[:spot]).first.coordinates
    elsif cookies[:lat_lng]
        @lat_lng = cookies[:lat_lng].split("|")
    end
    if @admin
       @locations = [Location.where(verified: false).order(:name), Location.where(verified: true).order(:name)].flatten
    elsif @lat_lng
        @locations = Location.near(@lat_lng, 30)
    else 
        @locations = Location.all
    end
    @locations =  @locations.select{|location| location.verified} unless @admin
  end

  # GET /locations/1
  # GET /locations/1.json
  def show
  end

  # GET /locations/new
  def new
    @location = Location.new
  end

  # GET /locations/1/edit
  def edit
	redirect_to locations_path unless @admin
  end

  # POST /locations
  # POST /locations.json
  def create
    @location = Location.new(location_params)
    @location.hours = params[:hours]
    respond_to do |format|
      if @location.save
        format.html { redirect_to @location, notice: 'Location was successfully created.' }
        format.json { render :show, status: :created, location: @location }
      else
        format.html { render :new }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /locations/1
  # PATCH/PUT /locations/1.json
  def update
    @location.hours = params[:hours]
    respond_to do |format|
      if @location.update(location_params)
        format.html { redirect_to @location, notice:  'Location was successfully updated.' }
        format.json { render :show, status: :ok, location: @location }
      else
        format.html { render :edit }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /locations/1
  # DELETE /locations/1.json
  def destroy
    return unless @admin
    @location.destroy
    respond_to do |format|
      format.html { redirect_to locations_url, notice: 'Location was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_location
      @location = Location.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def location_params
      params.require(:location).permit(:name, :address, :spot, :phone_number, :link, :verified, :pass, {:hours => {} }, :notes)
    end
    
    def check_admin 
     session[:admin] = "legit" if params[:pass] == "password"
     @admin = true if session[:admin] == "legit"
    end
end
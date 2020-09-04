class PeriodicCheckController < ApplicationController
  before_action :set_car
  before_action :set_car_periodic_check, only: [:show, :update, :destroy]

  # GET /car/:car_id/periodic_checks
  def index
    json_response(@car.periodic_checks)
  end

  # GET /car/:car_id/periodic_checks/:id
  def show
    json_response(@periodic_check)
  end

  # POST /car/:car_id/periodic_checks
  def create
    @car.periodic_checks.create!(periodic_check_params)
    json_response(@car.periodic_checks, :created)
  end

  # PUT /car/:car_id/periodic_checks/:id
  def update
    @periodic_check.update(periodic_check_params)
    head :no_content
  end

  # DELETE /car/:car_id/periodic_checks/:id
  def destroy
    @periodic_check.destroy
    head :no_content
  end

  private

  def periodic_check_params
    params.permit(:mileage, :gasPerformance, :passed, :maintenance)
  end

  def set_car
    @car = Car.find(params[:car_id])
  end

  def set_car_periodic_check
    @periodic_check = @car.periodic_checks.find_by!(params[:id]) if @car
  end
end

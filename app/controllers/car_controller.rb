class CarController < ApplicationController
  before_action :set_car, only: [:show, :update, :destroy]

  # GET /cars
  def index
    @car = Car.all
    json_response(@car)
  end

  # POST /cars
  def create
    @car = Car.create!(car_params)
    json_response(@car, :created)
  end

  # GET /cars/:id
  def show
    json_response(@car)
  end

  # PUT /cars/:id
  def update
    @car.update(car_params)
    head :no_content
  end

  # DELETE /cars/:id
  def destroy
    @car.destroy
    head :no_content
  end

  private

  def car_params
    # whitelist params
    params.permit(:owner, :carModel, :manufacturer)
  end

  def set_car
    @car = Car.find(params[:id])
  end
end

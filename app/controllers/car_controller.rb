class CarController < ApplicationController
  before_action :set_car, only: [:show, :update, :destroy]

  # GET /cars
  def index
    @car = current_user.cars
    json_response(@car)
  end

  # POST /cars
  def create
    if current_user.role == 'Admin'
      @car = current_user.cars.create!(car_params)
      json_response(@car, :created)
    else
      response = { message: Message.insufficient_privileges }
      json_response(response)
    end
  end

  # GET /cars/:id
  def show
    json_response(@car)
  end

  # PUT /cars/:id
  def update
    if current_user.role == 'Admin'
      @car.update(car_params)
      head :no_content
    else
      response = { message: Message.insufficient_privileges }
      json_response(response)
    end
  end

  # DELETE /cars/:id
  def destroy
    if current_user.role == 'Admin'
      @car.destroy
      head :no_content
    else
      response = { message: Message.insufficient_privileges }
      json_response(response)
    end
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

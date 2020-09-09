class CarController < ApplicationController
  before_action :set_car, only: [:show, :update, :destroy]

  # GET /cars
  def index
    @car = current_user.cars
    json_response(@car)
  end

  # POST /cars
  def create
    if current_user.admin
      @car = current_user.cars.create!(car_params)
      json_response(@car, :created)
    else
      insufficient_response
    end
  end

  # GET /cars/:id
  def show
    json_response(@car)
  end

  # PUT /cars/:id
  def update
    if current_user.admin
      @car.update(car_params)
      head :no_content
    else
      insufficient_response
    end
  end

  # DELETE /cars/:id
  def destroy
    if current_user.admin
      @car.destroy
      head :no_content
    else
      insufficient_response
    end
  end

  private

  def insufficient_response
    response = { message: Message.insufficient_privileges }
    json_response(response)
  end

  def car_params
    # whitelist params
    params.permit(:owner, :carModel, :manufacturer)
  end

  def set_car
    @car = Car.find(params[:id])
  end
end

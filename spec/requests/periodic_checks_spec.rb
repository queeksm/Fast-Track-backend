require 'rails_helper'

RSpec.describe 'periodic_check API' do
  # Initialize the test data
  let(:user) { create(:user) }
  let!(:car) { create(:car, owner: user.username) }
  let!(:periodic_check) { create_list(:periodic_check, 20, car_id: car.id) }
  let(:car_id) { car.id }
  let(:id) { periodic_check.first.id }
  let(:headers) { valid_headers }

  # Test suite for GET /car/:car_id/periodic_check
  describe 'GET /car/:car_id/periodic_check' do
    before { get "/car/#{car_id}/periodic_check", params: {}, headers: headers }

    context 'when car exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all car periodic_check' do
        expect(json.size).to eq(20)
      end
    end

    context 'when car does not exist' do
      let(:car_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to include("Couldn't find Car")
      end
    end
  end

  # Test suite for GET /car/:car_id/periodic_check/:id
  describe 'GET /car/:car_id/periodic_check/:id' do
    before { get "/car/#{car_id}/periodic_check/#{id}", params: {}, headers: headers }

    context 'when car periodic_check exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the periodic_check' do
        expect(json['id']).to eq(id)
      end
    end

    context 'when car periodic_check does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to include("Couldn't find PeriodicCheck")
      end
    end
  end

  # Test suite for POST /car/:car_id/periodic_check
  describe 'POST /car/:car_id/periodic_check' do
    let(:valid_attributes) { { mileage: 12000, gasPerformance: 12.5, passed: true, maintenance: Time.now }.to_json }

    context 'when request attributes are valid' do
      before { post "/checks/create/#{car_id}", params: valid_attributes, headers: headers }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before { post "/checks/create/#{car_id}", params: {}, headers: headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: Mileage can't be blank, Gasperformance can't be blank, Passed can't be blank, Maintenance can't be blank/)
      end
    end
  end

  # Test suite for PUT /car/:car_id/periodic_check/:id
  describe 'PUT /car/:car_id/periodic_check/:id' do
    let(:valid_attributes) { { mileage: 15000 }.to_json }

    before { put "/checks/update/#{car_id}/#{id}", params: valid_attributes, headers: headers }

    context 'when periodic_check exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

    end

    context 'when the periodic_check does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to include("Couldn't find PeriodicCheck")
      end
    end
  end

  # Test suite for DELETE /car/:id
  describe 'DELETE /car/:id' do
    before { delete "/checks/destroy/#{car_id}/#{id}", params: {}, headers: headers }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
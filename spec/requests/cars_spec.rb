require 'rails_helper'

RSpec.describe 'Car API', type: :request do
  # initialize test data 
  let!(:car) { create_list(:car, 10) }
  let(:car_id) { car.first.id }

  # Test suite for GET /cars
  describe 'GET /car' do
    # make HTTP get request before each example
    before { get '/car' }

    it 'returns cars' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /cars/:id
  describe 'GET /car/:id' do
    before { get "/car/#{car_id}" }

    context 'when the record exists' do
      it 'returns the car' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(car_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:car_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Car/)
      end
    end
  end

  # Test suite for POST /cars
  describe 'POST /car' do
    # valid payload
    let(:valid_attributes) { { owner: 'Elmo', carModel: 'cookie', manufacturer: 'Toyota' } }

    context 'when the request is valid' do
      before { post '/car', params: valid_attributes }

      it 'creates a car' do
        expect(json['owner']).to eq('Elmo')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/car', params: { owner: 'Foobar' } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Validation failed: Carmodel can't be blank, Manufacturer can't be blank/)
      end
    end
  end

  # Test suite for PUT /cars/:id
  describe 'PUT /car/:id' do
    let(:valid_attributes) { { owner: 'Zarathustra' } }

    context 'when the record exists' do
      before { put "/car/#{car_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for DELETE /cars/:id
  describe 'DELETE /car/:id' do
    before { delete "/car/#{car_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
require 'rails_helper'

RSpec.describe 'Car API', type: :request do
  # initialize test data
  let(:user) { create(:user) }
  let!(:car) { create_list(:car, 10, user_id: user.id) }
  let(:car_id) { car.first.id }
  let(:headers) { valid_headers }

  # Test suite for GET /cars
  describe 'GET /car' do
    # make HTTP get request before each example
    before { get '/car', params: {}, headers: headers }

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
    before { get "/car/#{car_id}", params: {}, headers: headers }

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
    let(:valid_attributes) do 
       { owner: 'Elmo', carModel: 'cookie', manufacturer: 'Toyota' }.to_json
    end

    context 'when the request is valid' do
      before { post '/car', params: valid_attributes, headers: headers }

      it 'creates a car' do
        expect(json['owner']).to eq('Elmo')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      let(:invalid_attributes) { {owner: nil}.to_json }
      before { post '/car', params: invalid_attributes, headers: headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(json['message'])
          .to match(/Validation failed: Owner can't be blank, Carmodel can't be blank, Manufacturer can't be blank/)
      end
    end
  end

  # Test suite for PUT /cars/:id
  describe 'PUT /car/:id' do
    let(:valid_attributes) { { owner: 'Zarathustra' }.to_json }

    context 'when the record exists' do
      before { put "/car/#{car_id}", params: valid_attributes, headers: headers }

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
    before { delete "/car/#{car_id}", params: {}, headers: headers }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
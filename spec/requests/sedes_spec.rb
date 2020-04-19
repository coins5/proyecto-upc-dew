require 'rails_helper'

RSpec.describe 'Sedes API', type: :request do
  # initialize test data 
  let(:user) { create(:user) }
  let!(:sedes) { create_list(:sede, 10) }
  let(:sede_id) { sedes.first.id }

  let(:headers) { valid_headers }

  # Test suite for GET /sedes
  describe 'GET /sedes' do
    # make HTTP get request before each example
    before { get '/sedes', params: {}, headers: headers }

    it 'returns sedes' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /sedes/:id
  describe 'GET /sedes/:id' do
    before { get "/sedes/#{sede_id}", params: {}, headers: headers }

    context 'when the record exists' do
      it 'returns the sede' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(sede_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:sede_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Sede/)
      end
    end
  end

  # Test suite for POST /sedes
  describe 'POST /sedes' do
    # valid payload
    # let(:valid_attributes) { { nombre: 'Una tienda de prueba', distrito: 'san borja' } }
    let(:valid_attributes) do
      # send json payload
      { nombre: 'Una tienda de prueba', distrito: 'san borja' }.to_json
    end

    context 'when the request is valid' do
      before { post '/sedes', params: valid_attributes, headers: headers }

      it 'creates a sede' do
        expect(json['nombre']).to eq('Una tienda de prueba')
        expect(json['distrito']).to eq('san borja')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      let(:invalid_attributes) { { nombre: 'otra tienda de prueba' }.to_json }
      #before { post '/sedes', params: { nombre: 'otra tienda de prueba' } }
      before { post '/sedes', params: invalid_attributes, headers: headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(json['message'])
          .to match(/Validation failed: Distrito can't be blank/)
      end
    end
  end

  # Test suite for PUT /sedes/:id
  describe 'PUT /sedes/:id' do
    let(:valid_attributes) { { nombre: 'una tienda adicional', distrito: 'san miguel' }.to_json }

    context 'when the record exists' do
      before { put "/sedes/#{sede_id}", params: valid_attributes, headers: headers }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for DELETE /sedes/:id
  describe 'DELETE /sedes/:id' do
    before { delete "/sedes/#{sede_id}", params: {}, headers: headers }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end

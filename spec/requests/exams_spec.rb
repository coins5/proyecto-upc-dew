require 'rails_helper'

RSpec.describe 'Exams API', type: :request do
  # initialize test data 
  let(:user) { create(:user) }
  let!(:exams) { create_list(:exam, 10) }
  let(:exam_id) { exams.first.id }

  let(:headers) { valid_headers }

  # Test suite for GET /exams
  describe 'GET /exams' do
    # make HTTP get request before each example
    #before { get '/exams' }
    before { get '/exams', params: {}, headers: headers }

    it 'returns exams' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /exams/:id
  describe 'GET /exams/:id' do
    #before { get "/exams/#{exam_id}" }
    before { get "/exams/#{exam_id}", params: {}, headers: headers }

    context 'when the record exists' do
      it 'returns the exam' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(exam_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:exam_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Exam/)
      end
    end
  end

  # Test suite for POST /exams
  describe 'POST /exams' do
    # valid payload
    # let(:valid_attributes) { { tipo_examen: 'fisiologico', name: 'planchas', description: 'se hacen planchas a lo yolo', minimo: 10, promedio: 30, maximo: 50 } }
    let(:valid_attributes) do
      # send json payload
      { tipo_examen: 'fisiologico', name: 'planchas', description: 'se hacen planchas a lo yolo', minimo: 10, promedio: 30, maximo: 50 }.to_json
    end
    context 'when the request is valid' do
      # before { post '/exams', params: valid_attributes }
      before { post '/exams', params: valid_attributes, headers: headers }

      it 'creates a exam' do
        expect(json['tipo_examen']).to eq('fisiologico')
        expect(json['name']).to eq('planchas')
        expect(json['description']).to eq('se hacen planchas a lo yolo')
        expect(json['minimo']).to eq(10)
        expect(json['promedio']).to eq(30)
        expect(json['maximo']).to eq(50)
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      # before { post '/exams', params: { tipo_examen: 'cualquier cosa' } }
      let(:invalid_attributes) { { tipo_examen: 'cualquier cosa' }.to_json }
      before { post '/exams', params: invalid_attributes, headers: headers }
      

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Validation failed: Name can't be blank, Description can't be blank, Minimo can't be blank, Promedio can't be blank, Maximo can't be blank/)
      end
    end
  end

  # Test suite for PUT /exams/:id
  describe 'PUT /exams/:id' do
    # let(:valid_attributes) { { nombre: 'una tienda adicional', distrito: 'san miguel' } }
    let(:valid_attributes) { { nombre: 'una tienda adicional', distrito: 'san miguel' }.to_json }

    context 'when the record exists' do
      before { put "/exams/#{exam_id}", params: valid_attributes, headers: headers }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for DELETE /exams/:id
  describe 'DELETE /exams/:id' do
    # before { delete "/exams/#{exam_id}" }
    before { delete "/exams/#{exam_id}", params: {}, headers: headers }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end

require 'rails_helper'

RSpec.describe 'users API', type: :request do
  # initialize test data 
  # let(:user) { create(:user) }
  let!(:users) { create_list(:user, 10) }
  # let!(:created_user) { build(:userasd) }
  let(:user) { users.first }
  let(:user_id) { users.first.id }


  let(:headers) { valid_headers }

  # Test suite for GET /users
  describe 'GET /users' do
    # make HTTP get request before each example
    # before { get '/users' }
    before { get '/users', params: {}, headers: headers }

    it 'returns users' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /users/:id
  describe 'GET /users/:id' do
    # before { get "/users/#{user_id}" }
    before { get "/users/#{user_id}", params: {}, headers: headers }

    context 'when the record exists' do
      it 'returns the user' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(user_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:user_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find User/)
      end
    end
  end

  # Test suite for POST /users
  describe 'POST /users' do
    # valid payload
    let(:valid_attributes) do 
      {
        tipo_usuario: 'normal',
        nombres: 'Nombre 1',
        apellidos: 'Apellido 1',
        direccion: 'Una direccion 123',
        distrito: 'san borja',
        tipo_documento: 'dni',
        numero_documento: '12345678',
        fecha_nacimiento: '1980-01-01',
        fecha_inicio: '2020-05-01',
        talla: 175,
        peso: 65,
        sexo: 'femenino',
        esta_en_escalada: true,
        esta_en_entrenamiento: true,
        email: 'email@correo.com',
        password: '654321',
        password_digest: '654321',
        password_confirmation: '654321',
        Password: '654321' #,
        #password_digest: '654321',
        #password_confirmation: '654321'
      }.to_json
    end

    context 'when the request is valid' do
      # before { post '/users', params: valid_attributes }
      before { post '/users', params: valid_attributes, headers: headers }

      it 'creates a user' do
        expect(json['tipo_usuario']).to eq('normal')
        expect(json['nombres']).to eq('Nombre 1')
        expect(json['apellidos']).to eq('Apellido 1')
        expect(json['direccion']).to eq('Una direccion 123')
        expect(json['distrito']).to eq('san borja')
        expect(json['tipo_documento']).to eq('dni')
        expect(json['numero_documento']).to eq('12345678')
        expect(json['fecha_nacimiento']).to eq('1980-01-01')
        expect(json['fecha_inicio']).to eq('2020-05-01')
        expect(json['talla']).to eq(175)
        expect(json['peso']).to eq(65)
        expect(json['sexo']).to eq('femenino')
        expect(json['esta_en_escalada']).to eq(true)
        expect(json['esta_en_entrenamiento']).to eq(true)
        expect(json['email']).to eq('email@correo.com')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      # before { post '/users', params: { nombres: 'Nombre 2' } }
      let(:invalid_attributes) { { nombres: 'Nombre 2' }.to_json }
      before { post '/users', params: invalid_attributes, headers: headers }

      it 'returns status code 422' do
        puts json
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        #expect(response.body)
        expect(json["message"])
          .to match(/Validation failed: Password can't be blank, Tipo usuario can't be blank, Apellidos can't be blank, Direccion can't be blank, Distrito can't be blank, Tipo documento can't be blank, Numero documento can't be blank, Fecha nacimiento can't be blank, Fecha inicio can't be blank, Talla can't be blank, Peso can't be blank, Sexo can't be blank, Esta en escalada can't be blank, Esta en entrenamiento can't be blank, Email can't be blank, Password digest can't be blank/)
      end
    end
  end

  # Test suite for PUT /users/:id
  describe 'PUT /users/:id' do
=begin
    let(:valid_attributes) { {
      tipo_usuario: 'normal',
      nombres: 'Nombre 3',
      apellidos: 'Apellido 1',
      direccion: 'Una direccion 123',
      distrito: 'san borja',
      tipo_documento: 'dni',
      numero_documento: '12345678',
      fecha_nacimiento: '1980-01-01',
      fecha_inicio: '2020-05-01',
      talla: 175,
      peso: 65,
      sexo: 'femenino',
      esta_en_escalada: true,
      esta_en_entrenamiento: false,
      email: 'email@correo.com'
    } }
=end
    let(:valid_attributes) do 
      {
        tipo_usuario: 'normal',
        nombres: 'Nombre 1',
        apellidos: 'Apellido 1',
        direccion: 'Una direccion 123',
        distrito: 'san borja',
        tipo_documento: 'dni',
        numero_documento: '12345678',
        fecha_nacimiento: '1980-01-01',
        fecha_inicio: '2020-05-01',
        talla: 175,
        peso: 65,
        sexo: 'femenino',
        esta_en_escalada: true,
        esta_en_entrenamiento: true,
        email: 'email@correo.com'
      }.to_json
    end

    context 'when the record exists' do
      # before { put "/users/#{user_id}", params: valid_attributes }
      before { put "/users/#{user_id}", params: valid_attributes, headers: headers }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for DELETE /users/:id
  describe 'DELETE /users/:id' do
    # before { delete "/users/#{user_id}" }
    before { delete "/users/#{user_id}", params: {}, headers: headers }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end

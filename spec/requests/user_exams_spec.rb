require 'rails_helper'

RSpec.describe 'User Exams API', type: :request do
  # initialize test data 
  let!(:user) { create(:user) }
  let!(:exam) { create(:exam) }
  let!(:user_exams) { create_list(:user_exam, 20, user_id: user.id, exam_id: exam.id) }
  let(:user_id) { user.id }
  let(:exam_id) { exam.id }
  let(:id) { user_exams.first.id }

  let(:headers) { valid_headers }

  # Test suite for GET /users/:user_id/user_exams
  describe 'GET /users/:user_id/user_exams' do
    # make HTTP get request before each example
    #before { get "/users/#{user_id}/user_exams" }
    before { get "/users/#{user_id}/user_exams", params: {}, headers: headers }

    context 'when user exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all todo items' do
        expect(json.size).to eq(20)
      end
    end

    context 'when user does not exist' do
      let(:user_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find User/)
      end
    end
  end

  # Test suite for GET /users/:user_id/user_exams/:id
  describe 'GET /users/:user_id/user_exams/:id' do
    # before { get "/users/#{user_id}/user_exams/#{id}" }
    before { get "/users/#{user_id}/user_exams/#{id}", params: {}, headers: headers }

    context 'when user_exam exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the user_exam' do
        expect(json['id']).to eq(id)
      end
    end

    context 'when user_exam does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        #expect(response.body["message"]).to match(/Couldn't find UserExam with [WHERE `user_exams`.`user_id` = ? AND `user_exams`.`id` = ?]/)
        expect(json["message"]).to match("Couldn't find UserExam with [WHERE `user_exams`.`user_id` = ? AND `user_exams`.`id` = ?]")
      end
    end
  end

  # Test suite for PUT /users/:user_id/user_exams
  describe 'POST /users/:user_id/user_exams' do
    let(:valid_attributes) { {
      fecha: '2020-04-28',
      puntaje: 25,
      user_id: 1,
      exam_id: exam_id
    }.to_json }

    context 'when request attributes are valid' do
      # before { post "/users/#{user_id}/user_exams", params: valid_attributes }
      before { post "/users/#{user_id}/user_exams", params: valid_attributes, headers: headers }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      # before { post "/users/#{user_id}/user_exams", params: {} }
      before { post "/users/#{user_id}/user_exams", params: {}, headers: headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        # expect(response.body).to match(/Validation failed: Exam must exist, Fecha can't be blank, Puntaje can't be blank/)
        expect(json["message"]).to match("Validation failed: Exam must exist, Fecha can't be blank, Puntaje can't be blank")
      end
    end
  end

  # Test suite for PUT /users/:user_id/user_exams/:id
  describe 'PUT /users/:user_id/user_exams/:id' do
    let(:valid_attributes) { {
      fecha: '2020-04-28',
      puntaje: 35,
      user_id: 1,
      exam_id: exam_id
    }.to_json }

    before { put "/users/#{user_id}/user_exams/#{id}", params: valid_attributes, headers: headers }

    context 'when user_exam exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates the user_exam' do
        updated_item = UserExam.find(id)
        expect(updated_item.puntaje).to eq(35)
      end
    end

    context 'when the item does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        # expect(response.body["message"]).to match(/Couldn't find UserExam with [WHERE `user_exams`.`user_id` = ? AND `user_exams`.`id` = ?]/)
        expect(json["message"]).to match("Couldn't find UserExam with [WHERE `user_exams`.`user_id` = ? AND `user_exams`.`id` = ?]")
      end
    end
  end

=begin
  # Test suite for PUT /user_exams/:id
  describe 'PUT /user_exams/:id' do
    let(:valid_attributes) { {
      fecha: '2020-04-28',
      puntaje: 25,
      user_id: 1,
      exam_id: 1
    } }

    context 'when the record exists' do
      before { put "/user_exams/#{user_exam_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end
=end

  # Test suite for DELETE /users/:user_id/user_exams/:id
  describe 'DELETE /users/:user_id/user_exams/:id' do
    before { delete "/users/#{user_id}/user_exams/#{id}", headers: headers }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end

=begin
  # Test suite for DELETE /user_exams/:id
  describe 'DELETE /user_exams/:id' do
    before { delete "/user_exams/#{user_exam_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
=end
end

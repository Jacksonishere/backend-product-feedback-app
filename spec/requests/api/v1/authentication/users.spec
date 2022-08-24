require 'rails_helper'
require 'airborne'

describe 'User crud actions', type: :request do
  context 'POST /api/v1/users' do
    it 'succesfully creates user' do
      expect {
        post '/api/v1/users', params: { user: { username: 'huntajack', email: 'huntajack@gmail.com', password: 'hello123', password_confirmation: 'hello123' } }
      }.to change(User, :count).by(1)

      expect(response).to have_http_status(:created)
      expect(response.parsed_body["data"]["id"].to_i).to eq(session[:current_user_id])
      # expect(response.parsed_body).to eq
    end

    it 'responds with 422 because invalid username' do
      expect {
        post '/api/v1/users', params: { user: { username: 'as', email: 'huntajack@gmail.com', password: 'hello123' } }
      }.to change(User, :count).by(0)
      
      expect(response).to have_http_status(:unprocessable_entity)
      expect(response.parsed_body["msg"]).to eq('Username is too short (minimum is 3 characters)')
    end
    
    it 'responds with 422 because username already exists' do
      FactoryBot.create(:user, username: 'Bookseller99', email:'duhhello@gmail.com', password: 'hello123', password_confirmation: 'hello123' )
      expect {
        post '/api/v1/users', params: { user: { username: 'Bookseller99', email: 'huntajack@gmail.com', password: 'hello123' } }
      }.to change(User, :count).by(0)
      
      expect(response).to have_http_status(:unprocessable_entity)
      expect(response.parsed_body["msg"]).to eq('Username has already been taken')
    end
  end
end
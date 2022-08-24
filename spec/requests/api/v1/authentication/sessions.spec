require 'rails_helper'

describe 'User session management', type: :request do
  let(:user) { FactoryBot.create(:user, username: 'huntajack', email: 'huntajack@gmail.com', password: 'hello123' ) }
  
  context 'POST /api/v1/login' do
    it 'successfully logs the user in' do
      user_id = user.id
      post '/api/v1/login', params: { user: { email: 'huntajack@gmail.com', password: 'hello123' } }
      
      expect(response.parsed_body['data']['id'].to_i).to eq(user_id)
      expect(session[:current_user_id]).to eq(user_id)
    end
    
    it 'unsuccessful attempt to log in the user' do
      user_id = user.id
      post '/api/v1/login', params: { user: { email: 'huntajack@gmail.com', password: 'hello12' } }
      
      expect(response).to have_http_status(:unauthorized)
      expect(response.parsed_body['msg']).to eq('Invalid credentials. Try again')
    end
  end

  # context 'DELETE /api/v1/logout' do
  #   it 'successfully logs user out if logged in' do
  #     # manually sign user in
  #     post '/api/v1/login', params: { user: { email: 'huntajack@gmail.com', password: 'hello123' } }
  #     id = response.parsed_body['data']['id']
      
  #     delete '/api/v1/logout'
      
  #     expect(response).to have_http_status(:no_content)
  #     expect(response.parsed_body['data']['msg']).to eq('successfully logged out')
  #     expect(session[:current_user_id]).to eq(nil)
  #   end
    
  #   it 'does not successfully log user out bcus not logged in' do
  #     delete '/api/v1/logout'

  #     expect(response).to have_http_status(:unauthorized)
  #     expect(response.parsed_body['data']['msg']).to eq('you are not logged in')
  #   end 
  # end
end
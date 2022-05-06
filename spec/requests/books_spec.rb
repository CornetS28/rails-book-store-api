require 'rails_helper'

describe 'Books API' do
  context 'GET /books' do
    it 'returns all books' do
      FactoryBot.create(:book, title: 'The Little Tiny Boy', author: 'George Neil')
      FactoryBot.create(:book, title: 'The Tom Boy', author: 'Danielle Style')

      get '/api/v1/books'

      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body).size).to eq(2)
    end
  end

  context 'POST /books' do
    it 'create a new book' do
      expect {  
        post '/api/v1/books', params: {book: { title: 'Game od Thrones', author: 'Martin Blue'}}
      }.to change { Book.count }.from(0).to(1)

       expect(response).to have_http_status(:created)
    end 
  end
end
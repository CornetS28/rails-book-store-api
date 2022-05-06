require 'rails_helper'

describe 'Books API' do
  context 'GET /books' do
    before do 
      FactoryBot.create(:book, title: 'The Little Tiny Boy', author: 'George Neil')
      FactoryBot.create(:book, title: 'The Tom Boy', author: 'Danielle Style')
    end

    it 'returns all books' do
      get '/api/v1/books'

      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body).size).to eq(2)
    end
  end

  context 'POST /books' do
    it 'create a new book' do
      expect {  
        post '/api/v1/books', params: {book: { title: 'Game of Thrones', author: 'Martin Blue'}}
      }.to change { Book.count }.from(0).to(1)

       expect(response).to have_http_status(:created)
    end 
  end

  describe 'DELETE /books:id' do
    let!(:book) { FactoryBot.create(:book, title: 'The Little Tiny Boy', author: 'George Neil') }
      it 'delete a book' do
        expect {  
          delete "/api/v1/books/#{book.id}"
        }.to change { Book.count }.from(1).to(0)

      expect(response).to have_http_status(:no_content)
    end 
      
  end
end
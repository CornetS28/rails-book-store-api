require 'rails_helper'

describe 'Books API', type: :request do
  let(:first_author) { FactoryBot.create(:author, first_name: 'James', last_name: 'Dindin', age: 34) }
  let(:second_author) { FactoryBot.create(:author, first_name: 'Jacob', last_name: 'Corbrane', age: 55) }

  context 'GET /books' do
    before do 
      FactoryBot.create(:book, title: 'The Little Tiny Boy', author: first_author)
      FactoryBot.create(:book, title: 'The Tom Boy', author: second_author)
    end

    it 'returns all books' do
      get '/api/v1/books'

      expect(response).to have_http_status(:success)
      expect(response_body.size).to eq(2)
      expect(response_body).to eq(
        [
          {
            'id' => 1,
            'title' => 'The Little Tiny Boy',
            'author_name' => 'James Dindin',
            'author_age' => 34
          },
          {
            'id' => 2,
            'title' => 'The Tom Boy',
            'author_name' => 'Jacob Corbrane',
            'author_age' => 55
          }
        ]
      )
    end
  end

  context 'POST /books' do
    it 'create a new book' do
      expect {  
        post '/api/v1/books', params: {
          book: { title: 'Game of Thrones'} ,
          author: { first_name: 'Martin', last_name: 'Blue', age: 54}
          }
      }.to change { Book.count }.from(0).to(1)

      expect(response).to have_http_status(:created)
      expect(Author.count).to eq(1)
      expect(response_body).to eq(
        {
          'id' => 1,
          'title' => 'Game of Thrones',
          'author_name' => 'Martin Blue',
          'author_age' => 54
        }
      )
    end 
  end

  context 'DELETE /books:id' do
    let!(:book) { FactoryBot.create(:book, title: 'The Little Tiny Boy', author: second_author) }
      it 'delete a book' do
        expect {  
          delete "/api/v1/books/#{book.id}"
        }.to change { Book.count }.from(1).to(0)

      expect(response).to have_http_status(:no_content)
    end 
  end
end
require 'rails_helper'

describe 'Books API' do
  it 'returns all books' do
    FactoryBot.create(:book, title: 'The Little Tiny Boy', author: 'George Neil')
    FactoryBot.create(:book, title: 'The Tom Boy', author: 'Danielle Style')

    get '/api/v1/books'

    expect(response).to have_http_status(:success)
    expect(JSON.parse(response.body).size).to eq(2)  
  end    
end
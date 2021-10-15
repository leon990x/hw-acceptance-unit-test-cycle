require 'rails_helper'
require 'support/action_controller_workaround'

describe Movie do
  describe 'find_similar_movies' do
    movie1 = FactoryGirl.create(:movie, title: 'Star Wars', director: 'George Lucas')
    movie2 =  FactoryGirl.create(:movie, title: 'Black Widow') 
    movie3 =  FactoryGirl.create(:movie, title: 'Captain Marvelous', director: 'Captain America') 
    

    context 'director exists' do
      it 'finds similar movies correctly' do
        expect(Movie.find_same_director(movie1.director)).to eql(['George Lucas'])
      end
    end

    context 'director does not exist' do
      it 'handles sad path' do
        expect(Movie.find_same_director(movie2.director)).to eql(nil)
      end
    end
    
    context 'director exists' do
      it 'finds similar movies correctly' do
        expect(Movie.find_same_director(movie3.director)).to eql(['Captain America'])
      end
    end
    
    context 'director exists' do
      it 'finds similar movies correctly' do
        expect(Movie.find_same_director(movie3.title)).to eql(['Captain Marvelous'])
      end
    end
    
  end

end
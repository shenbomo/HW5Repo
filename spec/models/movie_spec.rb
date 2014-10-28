require 'spec_helper'
 
describe Movie do
  describe 'searching Tmdb by keyword' do
    context 'with valid API key' do
      it 'should call Tmdb with title keywords' do
        expect(Tmdb::Movie).to receive(:find).with('Inception')
        Movie.find_in_tmdb('Inception')
      end
    end
    context 'with invalid API key' do
      before :each do
        Tmdb::Movie.stub(:find).and_raise(NoMethodError)
        Tmdb::Api.stub(:response).and_return({'code' => 401})
      end        
      it 'should raise an InvalidKeyError with no API key' do
        expect(lambda { Movie.find_in_tmdb('Inception') }).
          to raise_error(Movie::InvalidKeyError)
      end
    end
  end
  describe 'finding the movies details and adding them to the Rotten Potatoes database' do
    context 'with valid API key' do
      it 'should find the movies by Tmdb_ids' do
        expect(Movie).to receive(:create!).with(({:title=>"Fight Club", :rating=>"R", :release_date=>"1999-10-14"}))
        Movie.create_from_tmdb('550')
      end
    end
    context 'with invalid API key' do
      before :each do
        Tmdb::Movie.stub(:find).and_raise(NoMethodError)
        Tmdb::Api.stub(:response).and_return({'code' => 401})
      end        
      it 'should raise an InvalidKeyError with no API key' do
        expect(lambda { Movie.find_in_tmdb('Inception') }).
          to raise_error(Movie::InvalidKeyError)
      end
    end
  end
end
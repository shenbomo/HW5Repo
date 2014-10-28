require 'spec_helper'
 
describe MoviesController do
  describe 'searching TMDb' do
    before :each do
      @fake_results = [double('movie1'), double('movie2')]
    end
    it 'should call the model method that performs TMDb search' do
      expect(Movie).to receive(:find_in_tmdb).with('hardware').
        and_return(@fake_results)
      post :search_tmdb, {:search_terms => 'hardware'}
    end
    describe 'after valid search' do
      before :each do
        Movie.stub(:find_in_tmdb).and_return(@fake_results)
        post :search_tmdb, {:search_terms => 'hardware'}
      end
      it 'should select the Search Results template for rendering' do
        expect(response).to render_template('search_tmdb')
      end
      it 'should make the TMDb search results available to that template' do
        expect(assigns(:movies)).to eq (@fake_results)
      end
    end
  end
  describe 'adding TMDb' do
    before :each do
      @fake_results = [double('movie1'), double('movie2')]
    end
    it 'should call the model method that adds the movies to the database' do
      expect(Movie).to receive(:create_from_tmdb).with('550')
      post :add_tmdb, {:moviesHash => {'550'=>1}}
    end
    describe 'after adding' do
      before :each do
        Movie.stub(:create_from_tmdb).and_return(@fake_results)
        post :add_tmdb, {:moviesHash => 'hardware'}
      end
    end
  end
end
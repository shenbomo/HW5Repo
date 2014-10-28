class Movie < ActiveRecord::Base
  def self.all_ratings
    %w(G PG PG-13 R)
  end
  class Movie::InvalidKeyError < StandardError ; end

  def self.find_in_tmdb(string)
    
    begin
      Tmdb::Api.key("f4702b08c0ac6ea5b51425788bb26562")
      Tmdb::Movie.find(string)
    rescue NoMethodError => tmdb_gem_exception
      if Tmdb::Api.response['code'] == 401
        raise Movie::InvalidKeyError, 'Invalid API key'
      else
        raise tmdb_gem_exception
      end
    end
  end

  def self.create_from_tmdb(tmdb_id)
    begin
      Tmdb::Api.key("f4702b08c0ac6ea5b51425788bb26562")
      tempMovie = Tmdb::Movie.detail(tmdb_id)
      movieInfo = {:title => tempMovie.title, :rating => "R", :release_date => tempMovie.release_date}
      Movie.create!(movieInfo)     
            
    rescue NoMethodError => tmdb_gem_exception
      if Tmdb::Api.response['code'] == 401
        raise Movie::InvalidKeyError, 'Invalid API key'
      else
        raise tmdb_gem_exception
      end
    end
  end


end

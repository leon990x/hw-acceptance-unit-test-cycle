class Movie < ActiveRecord::Base
    def self.all_ratings
        return ["G", "PG", "PG-13", "R"]
    end
    
    
    def self.find_same_director(id)
        director = Movie.find_by(self.find(id).director)
        if director.blank? || director.nil?
            return nil
        end 
        Movie.where(director: director).pluck(:title)
    end

end

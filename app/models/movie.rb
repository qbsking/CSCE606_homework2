class Movie < ActiveRecord::Base
    RatingOrder = %w[G PG PG-13 R NC-17]
    def self.all_ratings
        RatingOrder & Movie.all.map(&:rating)
    end
end

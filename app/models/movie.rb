class Movie < ActiveRecord::Base
    def self.all_ratings
        all_ratings = Movies.order(:rating).pluck(:rating).uniq # don't retrieve unnecessary datas
        all_ratings << all_rating.delete('NC-17') # directly inject NC-17 at the end if exists
        all_ratings.compact # remove nil values
    end
end

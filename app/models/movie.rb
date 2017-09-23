class Movie < ActiveRecord::Base
    #attr_accessor :title, :rating, :description, :release_date
    def self.all_ratings
        a = Array.new
        self.pluck(:rating).each {|next_rating| a.push(next_rating)}
        a.sort.uniq
    end
end

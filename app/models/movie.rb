class Movie < ActiveRecord::Base
    #loads an array containing all possible ratings (for populating controls in css)
    def self.all_ratings
        a = Array.new
        self.pluck(:rating).each {|next_rating| a.push(next_rating)}
        a.sort.uniq
    end
end

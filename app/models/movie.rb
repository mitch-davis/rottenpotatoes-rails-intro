class Movie < ActiveRecord::Base
    #loads an array containing all possible ratings (for populating controls in css)
    def self.get_ratings
        a = Array.new
        self.pluck(:rating).each {|next_rating| a.push(next_rating)}
        if a.length > 0
            a.sort.uniq
        end
    end
end

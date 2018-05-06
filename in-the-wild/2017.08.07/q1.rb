# Find K hotels in our system with the highest/biggest number of visitors
# Input
# 1- map of user names and list of visited hotel ids.
# 2- K, the number of hotels that we want to find
# Output
# list of the top K Hotels sorted by the number of visitors

# Example Input:
# Alice visited:  [1, 3, 5, 6, 11, 15]
# Bob visited:    [1, 5, 7, 8, 19]
# Eve visited:    [5, 8]
#
# K=4
#

# Output, hotel_id, num_visitors
# 5,3
# 1,2
# 8,2
# 3,1

# my $input = [
#     [1, 3, 5, 6, 11, 15],    # Alice visited these hotels
#     [1, 5, 7, 8, 19],        # Bob visited these hotels
#     [5, 8]                   # Eve visited these hotels
#     ];


def k_most_visited input, k
   
   hotels_to_visits = Hash.new
   
   input.each do |user|
        user.each do |hotel_id|
            hotels_to_visits[hotel_id] = (hotels_to_visits[hotel_id] || 0) + 1
        end
   end
   
   sorted_hotels_and_visits = hotels_to_visits.to_a.sort { |a,b| a[1] < b[1] }
   
   return sorted_hotels_and_visits[0..k]
    
end

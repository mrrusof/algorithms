/*
Given two words, determine if the first word contains a substring, which is an anagram of the second word.
# Examples
 
Input:
"acting", "cat"
Output:
Anagram substring present
 
Input:
"acting", "catt"
Output:
No anagram substring present
 
Input:
"tracking", "act"
Output:
No anagram substring present
 
Anagram: "a type of word play, the result of rearranging the letters of a word or phrase to produce a new word or phrase, using all the original letters exactly once" (wikipedia.org)
Examples:
- cat, act
- read, dare
- caller, recall
- cleared, declare
*/

def anagram_substring s1, s2

    wl = s2.length
    zero_freqs = 0
    char_freqs = Hash.new
    
    # construct frequency counters
    s2.each do |c|
        char_freqs[c] = (char_freqs[c] || 0) + 1
    end
    
    # place the window on the left
    s1[0..wl].each do |c|
        if char_freqs.has_key? c
            char_freqs[c] -= 1
            if char_freqs[c] == 0
                zero_freqs += 1
            elsif char_freqs[c] == -1
                zero_freqs -= 1
            end
        end
    end
    
    # check if window on the left has an anagram
    if zero_freqs == char_freqs.length
        return true
    end
    
    # move window to the right one step at a time
    (wl..s1.length).each do |i|
        # disregard element that leaves the window from the left
        left_c = s2[i - wl]
        if char_freqs.has_key? left_c
            char_freqs[left_c] += 1
            if char_freqs[left_c] == 0
                zero_freqs += 1
            elsif char_freqs[left_c] == 1 ??
                zero_freqs -= 1
            end
        end
        
        # take into account element that enters the window from the right
        right_c = s2[i]
        if char_freqs.has_key? right_c
            char_freqs[right_c] -= 1
            if char_freqs[right_c] == 0
                zero_freqs += 1
            elsif char_freqs[right_c] == -1
                zero_freqs -= 1
            end
        end
        
        # check if window has an anagram
        if zero_freqs == char_freqs.length
            return true
        end
    end
    
    return false
end

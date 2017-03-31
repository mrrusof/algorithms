#!/usr/bin/env ruby

=begin

You are given a string `a` and a set of characters `b`.  Find the
shortest substring of `a` that consists of all and only the characters
in `b`.

a = aabbxbbcaab
          ---
b = abc


For each position, there is a shortest substring that ends in the
position and that includes as many chars of `b` as possible and no
other char.  Those substrings are the following.

a = aabbxbbcaab
    -
     -
     --
     ---
         -
          -
          --
          ---
          ----
           ----

For each position, the last position of each char in `b` that appears
between the last position (inclusive) and the last character not in
`b` is illustrated in the following diagram.

    01234567890
a = aabbxbbcaab
    |
     |
     ||
     | |

         |
          |
          ||
          |||
          || |
           | ||

The shortest substrings for each position, the ones that include all
the chars of `b` are the following.

a = aabbxbbcaab
          ---
          ----
           ----

=end

def shortest a, b
  left = -1
  last = b.chars.map { |c| [c, -1] }.to_h
  bcount = 0
  min_length = a.length + 1
  min_left = min_right = -1
  a.chars.each_with_index do |c, right|
    if not last.has_key? c
      left = right
      bcount = 0
    else
      bcount += 1 if last[c] <= left
      last[c] = right
      while last[a[left + 1]] != left + 1
        left += 1
      end
      length = right - left
      if bcount == b.length and length < min_length
        min_length = length
        min_left = left
        min_right = right
      end
    end
  end
  if min_length < a.length + 1
    return a[(min_left + 1)..min_right]
  else
    return nil
  end
end

while true
  a = readline.strip rescue break
  b = readline.strip rescue break
  puts shortest a, b
end

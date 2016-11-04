#!/usr/bin/env ruby

=begin

Input.
A set of words and a set of patterns.  Each word and each pattern is
given in a line by itself.  Words and patterns are separated by
character #.  The input is terminated by EOF.

Output.
For each pattern, write in a single line the pattern, a space, and
true if the pattern matches a word or false if it does not.  Output
patterns in the order you read them.

Example.

Input.

```
coin
coins
does
dork
why
work
#
coin
coins
c
co
coi
coins
coins.
.coins
does
d
do
doe
.oes
d.es
do.s
doe.
w..
w...
w....
```

Output.

```

```

=end

class Hash

  def save_word w
    h = self
    w.chars.each do |l|
      h[l] = {} if not h[l]
      h = h[l]
    end
    h[:eow] = true
  end

  def word_exists? w
    h = self
    w.chars.each_with_index do |l, i|
      if l == '.'
        return h.any? { |k,v| k != :eow and v.word_exists? w[i+1..-1] }
      elsif not h[l]
        return false
      end
      h = h[l]
    end
    return !!h[:eow]
  end

end

def main
  words = {}
  while true
    w = readline.strip
    break if w == '#'
    words.save_word w
  end
#  puts words
  while true
    begin
      p = readline.strip
    rescue EOFError => ex
      break
    end
    puts "#{p} #{words.word_exists? p}"
  end
end

main

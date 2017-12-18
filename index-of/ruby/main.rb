#!/usr/bin/env ruby

# When current prefix of search does not correspond to prefix of text,
# - Shifts are at most length of prefix of search.
# - Comparisons are at most (length of prefix of search - 1) * 2 + 1. (Accurate maybe?)

$current_prefix_comparisons = 0
$comparisons = 0
$shifts = 0

def prefix_length s, t, ps, pt
  $current_prefix_comparisons += 1
  return ps + 1 if t[pt] == s[ps]
  ps -= 1
  $shifts = $shifts + 1
  ct = pt
  while ps >= 0
    $comparisons += 1
    if t[ct] == s[ps]
      ct -= 1
      ps -= 1
    elsif ct < pt
      ct = pt
      $shifts += 1
    else
      ps -= 1
      $shifts += 1
    end
  end
  return pt - ct
end

def index_of search, text
  len_ps = 0
  (0...text.length).each do |pt|
    len_ps = prefix_length search, text, len_ps, pt
    return pt - len_ps + 1 if len_ps == search.length
  end
  return -1
end

def main
  text = readline.strip
  search = readline.strip
  puts index_of search, text
  puts "shifts = #{$shifts}"
  puts "current_prefix_comparisons = #{$current_prefix_comparisons}"
  puts "comparisons = #{$comparisons}"
end

main

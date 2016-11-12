#!/usr/bin/env ruby

=begin

Given a list of words and two words word1 and word2, return the shortest distance between these two words in the list.

For example, Assume that words = ["practice", "makes", "perfect", "coding", "makes"].

Given word1 = "coding", word2 = "practice", return 3. Given word1 = "makes", word2 = "coding", return 1.

Note
You may assume that word1 does not equal to word2, and word1 and word2 are both in the list.

=end

def swd ww, w1, w2
  w1p = nil
  w2p = nil
  md = ww.length
  ww.each_with_index do |w, i|
    if w == w1
      w1p = i
    elsif w == w2
      w2p = i
    end
    if w1p != nil and w2p != nil
      md = [md, (w1p - w2p).abs].min
    end
  end
  return md
end

[ [ ["practice", "makes", "perfect", "coding", "makes"], "coding", "practice", 3 ],
  [ ["practice", "makes", "perfect", "coding", "makes"], "practice", "coding", 3 ],
  [ ["practice", "makes", "perfect", "coding", "makes"], "makes", "coding", 1 ],
  [ ["practice", "makes", "perfect", "coding", "makes"], "coding", "makes", 1 ]
].each do |ww, w1, w2, exp|
  if exp == swd(ww, w1, w2)
    print 'PASS'
  else
    print 'FAIL'
  end
  puts " swd #{ww}, #{w1}, #{w2} = #{exp}"
end

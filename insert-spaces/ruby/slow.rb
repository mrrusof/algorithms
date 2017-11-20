#!/usr/bin/env ruby

# Given text s and list of words d,
#
# Time is O(NML), N = |s|, M = |d|, L = length of longest word in d
# Space is O(N^2)

def is s, d, done, i
  return 0, [] if i == s.length
  return done[i] if !!done[i]
  cuc, cs = is s, d, done, i + 1
  muc = 1 + cuc
  msplit = cs
  d.each do |w|
    if w == s[i...i + w.length]
      cuc, cs = is s, d, done, i + w.length
      if cuc < muc
        muc = cuc
        msplit = [i - 1, i + w.length - 1] + cs
      end
    end
  end
  done[i] = [muc, msplit]
  return [muc, msplit]
end

def insert_spaces s, d
  _, split = is s, d, {}, 0
  last_p = -1
  spaced = ""
  split.each do |p|
    next if p < 0 || p == s.length - 1 || p == last_p
    spaced += s[last_p + 1..p] + " "
    last_p = p
  end
  return spaced + s[last_p + 1..-1]
end

def main
  [ ["tomwritessomuchcodethathesometimesforgetswhathewrote", ["writes",
                                                              "so",
                                                              "sometimes",
                                                              "code",
                                                              "that",
                                                              "what",
                                                              "hat",
                                                              "the",
                                                              "wrote",
                                                              "rote"], "tom writes so much code that he sometimes forgets what he wrote"],
    ["claravisitsherbrothertom", ["visits",
                                  "sits",
                                  "she",
                                  "her",
                                  "other",
                                  "brother"], "clara visits her brother tom"],
    ["claravisitstomherbrother", ["visits",
                                  "sits",
                                  "she",
                                  "her",
                                  "other",
                                  "brother"], "clara visits tom her brother"]
  ].each do |s, d, e|
    a = insert_spaces s, d
    print "insert_spaces '#{s}', d = '#{a}' ... "
    if a == e
      puts 'PASS'
    else
      puts 'FAIL'
    end
  end
end

main

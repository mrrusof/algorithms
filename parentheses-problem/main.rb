#!/usr/bin/env ruby

=begin

Consider an input string that may contain any number of parentheses '(' and ')'.
Remove from the string the minimum number of parentheses in order to balance the rest of the parenthesis.
Return all possible results.

Examples:
"()())()" -> ["()()()", "(())()"]
"(a)())()" -> ["(a)()()", "(a())()"]
")(" -> [""]

=end

def s(v, p, acc, t)
  if t.length == 0
    if p > 0
      # nothing!
      return []
    else
      # valid string...
      return [[acc, v]]
    end
  elsif t[0] == '('
    # you take it ...
    izq = s(v, p + 1, "#{acc}#{t[0]}", t[1..-1])
    # ... or you leave it
    der = s(v + 1, p, acc, t[1..-1])
    return izq.concat der
  elsif t[0] == ')'
    # can you take it?...
    izq = []
    if p > 0
      izq = s(v, p - 1, "#{acc}#{t[0]}", t[1..-1])
    end
    # ... or you just leave it
    der = s(v + 1, p, acc, t[1..-1])
    return izq.concat der
  end
  # ... just take it
  return s(v + 1, p, "#{acc}#{t[0]}", t[1..-1])

end

def solve(t)
  r = s(0, 0, "", t)
  min = r.reduce(t.length) { |min, e| if e[1] < min then e[1] else min end }
  return r.keep_if { |e| e[1] == min }.map { |e| e.first }.uniq
end

t = readline().strip
s = solve(t)
puts s

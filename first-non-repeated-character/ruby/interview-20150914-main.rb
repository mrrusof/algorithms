#!/usr/bin/env ruby

def fnr(text)
  # IN:  "a a"
  # OUT: nil

  # IN:  "hola mundo"
  #       0123456789
  #
  #       h o l a m u n d
  #       0 1 2 3 5 6 7 8
  #
  # OUT: h

  repeated = ""
  text.chars.each_with_index do |c, i|

    # does c appear in suffix of text (that is, is c in text[i,-1])?
    c_regexp = Regexp.new(c)

    suffix = text[i+1, text.length - i+1]
#    puts "suffix = \"#{suffix}\""


    # index = 'a'
    # first = 3
    # ...
    # index = 'h'
    # first = 3

    # count[0] = 0
    # ...
    # count['a'] = 1
    # count['h'] = 1
    # count['o'] = 1

    # pos['a'] = 3
    # pos['h'] = 0
    # pos['z'] = -1

    if not c_regexp =~ suffix and not c_regexp =~ repeated
        # c is the first character that is not repeated
        return c
    end

    # c is repeated
    repeated = "#{repeated}#{c}"
  end

  return nil
end

actuals   =  [ "a a", "hola mundo", "ola mundo", "", "a", "aabb", "  a  " ]
# expected = [ " ",   "h",          "l"         ]
actuals.each do |a|
  # e.g. "fnr("a a") = " "
  r = fnr(a)
  if r == nil
    puts "fnr(\"#{a}\") = nil"
  else
    puts "fnr(\"#{a}\") = \"#{fnr(a)}\""
  end
end

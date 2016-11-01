#!/usr/bin/env ruby

=begin

Convert a non-negative integer to its english words representation. Given input is guaranteed to be less than 2^31 - 1.

For example,
123 -> "One Hundred Twenty Three"
12345 -> "Twelve Thousand Three Hundred Forty Five"
1234567 -> "One Million Two Hundred Thirty Four Thousand Five Hundred Sixty Seven"

=end

# (1..31).each { |n| puts "2^#{n} = #{2 ** n}" }

def prefix1(n)
  case n
  when 2
    return 'Twen'
  when 3
    return 'Thir'
  when 4
    return 'Four'
  when 5
    return 'Fif'
  when 6
    return 'Six'
  when 7
    return 'Seven'
  when 8
    return 'Eigh'
  when 9
    return 'Nine'
  end
  return 'prefix1'
end

def natural_to_prose(n)
  case n
  when 0..9
    return {
      0 => 'Zero',
      1 => 'One',
      2 => 'Two',
      3 => 'Three',
      4 => 'Four',
      5 => 'Five',
      6 => 'Six',
      7 => 'Seven',
      8 => 'Eight',
      9 => 'Nine' }[n]
  when 10
    return 'Ten'
  when 11
    return 'Eleven'
  when 12
    return 'Twelve'
  when 13..19
    return "#{prefix1(n - 10)}teen"
  when 40
    return 'Forty'
  when 20, 30, 50, 60, 70, 80, 90
    return "#{prefix1(n / 10)}ty"
  when 21..99
    return "#{natural_to_prose(n / 10 * 10)} #{natural_to_prose(n % 10)}"
  when 100..999
    if n % 100 > 0
      return "#{natural_to_prose(n / 100)} Hundred #{natural_to_prose(n % 100)}"
    else
      return "#{natural_to_prose(n / 100)} Hundred"
    end
  when 1000..999999
    if n % 1000 > 0
      return "#{natural_to_prose(n / 1000)} Thousand #{natural_to_prose(n % 1000)}"
    else
      return "#{natural_to_prose(n / 1000)} Thousand"
    end
  when 1000000..999999999
    if n % 1000000 > 0
      return "#{natural_to_prose(n / 1000000)} Million #{natural_to_prose(n % 1000000)}"
    else
      return "#{natural_to_prose(n / 1000000)} Million"
    end
  when 1000000000..999999999999
    if n % 1000000000 > 0
      return "#{natural_to_prose(n / 1000000000)} Billion #{natural_to_prose(n % 1000000000)}"
    else
      return "#{natural_to_prose(n / 1000000000)} Billion"
    end
  end
  return nil
end

test_cases = {
  0 => 'Zero',
  5 => 'Five',
  14 => 'Fourteen',
  30 => 'Thirty',
  27 => 'Twenty Seven',
  100 => 'One Hundred',
  123 => 'One Hundred Twenty Three',
  12345 => 'Twelve Thousand Three Hundred Forty Five',
  1234567 => 'One Million Two Hundred Thirty Four Thousand Five Hundred Sixty Seven',
  2147483648 => 'Two Billion One Hundred Forty Seven Million Four Hundred Eighty Three Thousand Six Hundred Forty Eight',
  1234567891 => 'One Billion Two Hundred Thirty Four Million Five Hundred Sixty Seven Thousand Eight Hundred Ninety One'
}

test_cases.each { |k, v|
  p = natural_to_prose(k)
  print "#{k} => '#{v}' ? "
  if v == p
    puts 'Yes'
  else
    puts "No, '#{p}'"
  end
}

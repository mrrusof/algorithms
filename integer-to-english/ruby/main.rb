#!/usr/bin/env ruby

$u = [
"Zero",
"One",
"Two",
"Three",
"Four",
"Five",
"Six",
"Seven",
"Eight",
"Nine"
]
def units n
  $u[n]
end

def hundreds n
  units(n) + " Hundred"
end

$t = {
  10 => "Ten",
  11 => "Eleven",
  12 => "Twelve",
  13 => "Thirteen",
  14 => "Fourteen",
  15 => "Fifteen",
  16 => "Sixteen",
  17 => "Seventeen",
  18 => "Eighteen",
  19 => "Nineteen"
}
def teens n
  $t[n]
end

$tt = [
  "",
  "",
  "Twenty",
  "Thirty",
  "Forty",
  "Fifty",
  "Sixty",
  "Seventy",
  "Eigthy",
  "Ninety"
]
def tens n
  $tt[n]
end

def part_to_english n
  s = ""
  if n >= 100
    s += hundreds(n / 100)
    n %= 100
    s += " " if n > 0
  end

  if n > 9 and n < 20
    s += teens(n)
    return s
  end

  if n > 19
    s += tens(n / 10)
    n %= 10
    s += " " if n > 0
  end

  if n > 0
    s += units(n)
  end

  return s

end

$seps = [
  "",
  " Thousand",
  " Million"
]

def int_to_english n
  return "Zero" if n == 0
  parts = []
  while n > 0
    p = n % 1000
    n = n / 1000
    s = part_to_english p
    parts.push s if s.length > 0
  end
  s = ""
  while parts.length > 1
    s += parts.pop
    s += $seps[parts.length]
    s += ", "
  end
  return s + parts.pop
end

while true
  n = readline.to_i rescue break
  puts int_to_english n
end

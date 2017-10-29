#!/usr/bin/env ruby

def dl r, c
  return 8 - r + c
end

def dr r, c
  return r + c
end

def q r, qp, fcc, fdl, fdr
  return true if r == 8
  (0..7).each do |c|
    next if fcc[c] || fdl[dl(r, c)] || fdr[dr(r, c)]
    fcc[c] = true
    fdl[dl(r, c)] = true
    fdr[dr(r, c)] = true
    qp[r] = c
    if q r + 1, qp, fcc, fdl, fdr
      return true
    end
    fcc[c] = false
    fdl[dl(r, c)] = false
    fdr[dr(r, c)] = false
  end
  return false
end

def queens
  qp = (0...8).to_a
  fcc = (1..8).map {|_| false }
  fdl = (1..15).map {|_| false }
  fdr = (1..15).map {|_| false }
  q 0, qp, fcc, fdl, fdr
  return qp
end

def main
  qp = queens
  (0...8).each do |r|
    print "#{r}: | "
    (0...8).each do |c|
      if c == qp[r]
        print '_ '
      else
        print '. '
      end
    end
    puts '|'
  end
end

main

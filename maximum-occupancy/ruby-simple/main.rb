#!/usr/bin/env ruby

# # Simple?
# def maximum_occupancy reservations
#   return nil if reservations.empty?
#   events = []
#   reservations.each { |r|
#     i, o = r
#     events << [i, 1]
#     events << [o, -1]
#   }
#   events.sort! { |a, b| a.first <=> b.first }
#   events << [:end, 0]
#   occupancies = []
#   curr_day = events.first.first
#   curr_occ = events.first[1]
#   events[1..-1].each { |day, occ|
#     if day != curr_day
#       occupancies << curr_occ
#       curr_day = day
#     end
#     curr_occ += occ
#   }
#   return occupancies.max
# end

# # Really simple? Define simple.
# def maximum_occupancy reservations
#   return nil if reservations.empty?
#   deltas = {}
#   reservations.each { |r|
#     i, o = r
#     deltas[i] ||= 0
#     deltas[i] += 1
#     deltas[o] ||= 0
#     deltas[o] -= 1
#   }
#   sorted_deltas = deltas.to_a.sort { |a, b| a.first <=> b.first }
#   occ = 0
#   occupancies = sorted_deltas.map { |d| occ += d[1] }
#   return occupancies.max
# end

def sorted_deltas reservations
  deltas = {}
  reservations.each { |day_in, day_out|
    deltas[day_in] ||= 0
    deltas[day_in] += 1
    deltas[day_out] ||= 0
    deltas[day_out] -= 1
  }
  return deltas.to_a.sort { |a, b| a.first <=> b.first }.map { |day, delta| delta }
end

def occupancies sorted_deltas
  occ = 0
  return sorted_deltas.map { |delta| occ += delta }
end

def maximum_occupancy reservations
  sd = sorted_deltas reservations
  occs = occupancies sd
  return occs.max
end

n = readline.strip.to_i
reservations = []
while n > 0
  r = readline.strip.split(' ').map(&:to_i) rescue break
  reservations << r
  n -= 1
end
puts maximum_occupancy reservations

# Problem

You work for a chain of hotels. The central management asks you to
make a report that includes some metrics for each month and hotel.
The report must include the maximum occupancy.  Given that the only
data you have that is related to occupancy is a list of room
reservations for each month and hotel, how do you obtain the maximum
occupancy?

For a given hotel and day, occupancy is the number of rooms that are
occupied on that day.  We consider that a room is occupied when the
reservation is paid.  After a room is paid, we do not make the room
available even if guests do not show up on the first date of their
reservation.

Each reservation that you have is fully paid.  Each reservation
consists of a check-in date and a check-out date.  Each reservation
corresponds to a single room.  For that reason, two overlapping
reservations correspond to different rooms.  Given a reservation, the
corresponding room is occupied on all dates of the reservation except
the check-out date.

Consider the following example.  Suppose that on February 2017 there
were only 5 reservations for our hotel in Cancun.

```
Reservation   Check-in    Check-out
1             2017/02/01  2017/02/03
2             2017/02/03  2017/02/05
3             2017/02/05  2017/02/07
4             2017/02/05  2017/02/08
5             2017/02/05  2017/02/09
6             2017/02/10  2017/02/11
```

The maximum occupancy is 3 and it happened on February 5 and 6.

**Input.**
The input file consists of one or more cases.  Each case begins with a
number `n` on a line of its own.  Following `n`, there are `n`
reservations corresponding to the case, each on a separate line.  Each
reservation consists of two numbers separated by one or more spaces.
The first number of a given reservation corresponds to the day of the
month where a check-in happened.  The second number corresponds to the
check-out day.  The input file is terminated by an EOF character.
Consider the following example.

```
6
1 3
3 5
5 7
5 8
5 9
10 11
```

**Output.**
The output file consists of an output line for each case.  Each output
line consists of a single integer, the maximum occupancy for the case.
For example, the following output corresponds to the previous example
input.

```
3
```

# Solution

Our proposed solution belongs to complexity class `O(n log n)`.

Consider the following timeline of the reservations given by the
example in the problem statement.

```
   1   2   3   4   5   6   7   8   9   10  11  12  ... <-- Day of month

1: i       o
2:         i       o
3:                 i       o
4:                 i           o
5:                 i               o
6:                                     i   o
^
|
 \
  Reservation
```

Imagine that we sweep a line over the diagram from left to right.  We
start with an occupancy of zero and every time we step over at least
one `i` or `o`, we add the number of `i`'s and subtract the number of
`o`'s.  After doing all additions and subtractions, we obtain the
occupancy for the corresponding day of the month.  We annotate the
current occupancy below the day of the month, like so.

```
   1   2   3   4   5   6   7   8   9   10  11  12  ... <-- Day of month

   1       1       3       2   1   0   1   0       <-- Occupancy

1: i       o
2:         i       o
3:                 i       o
4:                 i           o
5:                 i               o
6:                                     i   o
^
|
 \
  Reservation
```

The result is the maximum amongst the annotated occupancies.

The sweeping of the line corresponds to considering check-ins and
check-outs in chronological order.  We do not need to consider dates
that do not have a corresponding check-in or check-out (i.e. days 2,
4, 6, and everything after 11).  To do that, sort the check-ins and
check-outs and then consider each by taking every time the most recent
check-in or check-out first.  Consider the following Ruby
procedure.

```ruby
# ii: array of check-ins
# oo: array of check-outs
def sweep_line ii, oo
  ii.sort!
  oo.sort!
  a = b = 0
  while a < ii.length or b < oo.length
    if b == oo.length or a < ii.length and ii[a] < oo[b]
      puts "check-in on #{ii[a]}"
      a += 1
    else
      puts "check-out on #{oo[b]}"
      b += 1
    end
  end
end
```

For the example input, the previous procedure prints the following.

```
check-in on 1
check-out on 3
check-in on 3
check-out on 5
check-in on 5
check-in on 5
check-in on 5
check-out on 7
check-out on 8
check-out on 9
check-in on 10
check-out on 11
```

Given the procedure for sweeping the line, compute the occupancy every
time the date changes, like so.

```ruby
def occupancies ii, oo
  curr_date = 1
  curr_occupancy = 0
  ii.sort!
  oo.sort!
  a = b = 0
  while a < ii.length or b < oo.length
    if b == oo.length or a < ii.length and ii[a] < oo[b]
      if curr_date != ii[a]
        puts "occupancy on #{curr_date} is #{curr_occupancy}"
        curr_date = ii[a]
      end
      curr_occupancy += 1
      a += 1
    else
      if curr_date != oo[b]
        puts "occupancy on #{curr_date} is #{curr_occupancy}"
        curr_date = oo[b]
      end
      curr_occupancy -= 1
      b += 1
    end
  end
  puts "occupancy on #{curr_date} is #{curr_occupancy}"
end
```

For the example input, the previous procedure prints the following.

```
occupancy on 1 is 1
occupancy on 3 is 1
occupancy on 5 is 3
occupancy on 7 is 2
occupancy on 8 is 1
occupancy on 9 is 0
occupancy on 10 is 1
occupancy on 11 is 0
```

Given the procedure for computing occupancies, select the maximum like
so.

```ruby
def maximum_occupancy ii, oo
  max = 0
  curr_date = 1
  curr_occupancy = 0
  ii.sort!
  oo.sort!
  a = b = 0
  while a < ii.length or b < oo.length
    if b == oo.length or a < ii.length and ii[a] < oo[b]
      if curr_date != ii[a]
        curr_date = ii[a]
        max = curr_occupancy if max < curr_occupancy
      end
      curr_occupancy += 1
      a += 1
    else
      if curr_date != oo[b]
        curr_date = oo[b]
        max = curr_occupancy if max < curr_occupancy
      end
      curr_occupancy -= 1
      b += 1
    end
  end
  max = curr_occupancy if max < curr_occupancy
  return max
end
```

Given the example input, the return value for the previous procedure
is `3`.

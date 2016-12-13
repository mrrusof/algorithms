#!/usr/bin/env ruby

# Ex. 15.1-5

def fibonacci n
  return 1 if n < 2
  fi_1 = 1
  fi_2 = 1
  i = 1
  while (i += 1) <= n
    fi = fi_1 + fi_2
    fi_2 = fi_1
    fi_1 = fi
  end
  return fi
end

puts fibonacci(10)

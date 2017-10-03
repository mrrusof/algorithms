import sys

def netmask(a, b, c, d):
    candidate = (a << 24) + (b << 16) + (c << 8) + d
    if candidate < 4278190080 or candidate > 4294967292:
        return False
    complement = ~candidate & 4294967295
    succ_complement = complement + 1
    return complement & succ_complement == 0

btos = { True: 'true', False: 'false' }

for line in sys.stdin:
    a, b, c, d = map(int, line.split('.'))
    print(btos[netmask(a, b, c, d)])

########################################
# Read input

def read_input_csv():
    import sys
    import csv

    reader = csv.reader(sys.stdin)

    _header = next(reader)

    rows = []
    for row in reader:
        rows.append(row)

    return rows


########################################
# Preprocessing input

def hash_string(s):
    # Hashing as 32-bit integer ensures that integer comparisons
    # happen in constant time as opposed to linear time for bignums.
    return abs(hash(s.strip())) & 0xFFFFFFFF 


def hash_rows(rows):
    hashed_rows = []

    for row in rows:
        hashed_row = [int(row[0])]

        for cell in row[1:]:
            hashed_row.append(hash_string(cell))

        hashed_rows.append(hashed_row)

    return hashed_rows


########################################
# Indexing

def count_cols(rows):
    first = rows[0]
    return len(first)


def subsets_count_for_cardinality(cardinality):
    return 2 ** cardinality


def get_bits(n):
    ones_count = 0
    bits = []

    while n > 0:
        if n & 1 == 1:
            ones_count += 1
            bits.append(1)
        else:
            bits.append(0)
            
        n = n >> 1

    return [bits, ones_count]


class SubsetIndex:
    def __init__(self, index_id):
        bits, ones_count = get_bits(index_id)

        self.key_mask = bits
        self.key_cardinality = ones_count
        self.data = {}


    def key_for_row(self, row):
        key = []
    
        for i, bit in enumerate(self.key_mask):
            if bit == 1:
                key.append(row[1 + i]) # skip the id, first column
    
        return tuple(key)

    
    def put(self, row, v):
        key = self.key_for_row(row)
        self.data[key] = v


    def get(self, row):
        key = self.key_for_row(row)
        return self.data.get(key)


def init_indices(col_count):
    all_indices = []
    indices_by_cardinality = {}
    subsets_count = subsets_count_for_cardinality(col_count - 1)

    for i in range(1, subsets_count):
        index = SubsetIndex(i)

        indices_by_cardinality.setdefault(index.key_cardinality, [])
        indices_by_cardinality[index.key_cardinality].append(index)

        all_indices.append(index)

    return [all_indices, indices_by_cardinality]


def index(rows):
    col_count = count_cols(rows)
    all_indices, indices_by_cardinality = init_indices(col_count)

    for row in rows:
        for index in all_indices:
            if index.get(row) is None:
                row_id = row[0]
                index.put(row, row_id)

    return indices_by_cardinality


########################################
# Smallest canonical users/rows lookup

def find_most_frequent_and_smallest_row(row, indices_by_cardinality):
    row_id = row[0]
    col_count = len(row)

    for cardinality in range(col_count - 1, 0, -1):
        most_frequent_and_smallest_row = None

        for index in indices_by_cardinality[cardinality]:
            similar_id = index.get(row)

            if similar_id is None or similar_id == row_id:
                continue

            if most_frequent_and_smallest_row is None or similar_id < most_frequent_and_smallest_row:
                most_frequent_and_smallest_row = similar_id

        if not most_frequent_and_smallest_row is None:
            return [most_frequent_and_smallest_row, cardinality]

    return [None, 0]


def find_smallest_canonical_rows(rows, indices_by_cardinality):
    result = []

    for row in rows:
        row_id = row[0]
        smallest_canonical_row, similarity = find_most_frequent_and_smallest_row(row, indices_by_cardinality)

        result.append([row_id, smallest_canonical_row, similarity])
    
    return result


########################################
# Pretty printing

def pretty_similarity_value(similarity):
    if similarity < 2:
        return 'Low'
    elif similarity < 3:
        return 'Medium'
    else:
        return 'High'


def pretty_print(result_rows):
    print("id1,id2,similarity")

    for row in result_rows:
        id1 = row[1]
        id2 = row[0]
        similarity = pretty_similarity_value(row[2])

        if id1 is None:
            continue
        
        print(f"{id1},{id2},{similarity}")


def main():
    rows = read_input_csv()

    if len(rows) == 0:
        return

    hashed_rows = hash_rows(rows)
    indices_by_cardinality = index(hashed_rows)
    rows_with_smallest_canonical_row = find_smallest_canonical_rows(hashed_rows, indices_by_cardinality)
    pretty_print(rows_with_smallest_canonical_row)


main()


Given a set of hotels and its guest reviews, sort the hotels base on a
list of words specified by a user.  The criteria to sort the hotels
should be how many times the words specified by the user is mentioned
in the hotel reviews.

# Input

The first line contains a space-separated set of word which we want to
find mentions in the hotel reviews.  The second line contains one
integer M, which is the number of reviews.  This is followed by  M+M
lines which alternate between an hotel ID and a review beloging to
that hotel.

# Output

A list of hotel IDs sorted, in descending order, by how many mentions
they have of the words specified in the input.

# Constraints
- Keywords will always be single words like 'breakfast' and
  'room'. Keywords will never be compound like 'swimming pool'.
- Hotel ID is a 4-byte integer.
- Word match should be case-insensitive.
- Dots and commas should be ignored.
- If a word appears in a review twice, it should count twice.
- If two hotels have the same number of mentions, they should be
  sorted in the output based on their ID, smallest ID first.
- In case one or more test cases time out, consider   revisiting the
  runtime complexity of your algorithms.

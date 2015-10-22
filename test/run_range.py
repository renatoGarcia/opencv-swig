#! /usr/bin/python3

import range

r = range.return_Range()
assert(r.start == 13)
assert(r.end == 42)

range.receive_Range(range.Range(10, 15))

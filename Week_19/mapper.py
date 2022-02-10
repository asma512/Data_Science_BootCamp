#!/usr/bin/env python
import sys
for line in sys.stdin:
    line = line.strip()
    words = line.split()
    for word in words:
        print(word + "\t")



#mapper -  breaking up words into units


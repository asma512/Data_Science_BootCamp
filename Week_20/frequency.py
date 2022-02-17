#!/usr/bin/env python
import sys
import re
from collections import Counter

frequency_list=[]
for line in sys.stdin:
    line = line.strip().lower()
    words = line.split()
    for word in words:
        word_list = re.findall(r"[\w]+|[^\s\w]", word)
        frequency_list+=[w for w in word_list]
        
counts = Counter(frequency_list)
sort_freq = sorted(counts.items(), key=lambda x: (x[1],x[0]), reverse=True)
print(sort_freq)
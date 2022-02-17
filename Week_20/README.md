### 1.	Write a python program (not a Jupyter notebook, but a py file you run from the command line) that accepts the cats_txt.txt file as input and counts the frequency of all words and punctuation in that text file, ordered by frequency. Make sure to handle capital and lowercase versions of words and count them together.
```
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
```


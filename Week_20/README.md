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
### 2.	Document how to run the program you created in question 1 in a readme.md file in your repo. Be as clear as possible. Use proper markdown and consider using screenshots. Be sure to briefly discuss why this kind of exercise might be helpful for NLP in your markdown.

1. Open the terminal and change to the directory with frequency.py
2. Enter the name of text file as the input in the terminal :
    - cat cats_txt.txt | ./frequency.py
    - cat command allows us to concatenate text file
    - | pipes to the .py file



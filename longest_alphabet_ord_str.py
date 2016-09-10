#!/usr/bin/env python
# -*- coding: utf-8 -*-

# pre-set string
s = "adaabcddkvbabcdefgoerei"

# alphabetical order?
def in_alphabetical_order(word):
    for n in range(len(word) -1):
        if(word[n] > word[n+1]):
            return False
    return True


# alg
'''
b = 0
end = 1
s[b:end] ? end += 1 > loop ||| b += 1 end += 1 > loop 
'''
b = 0
end = 1
while(end <= len(s)):
    word = s[b:end]
    if(in_alphabetical_order(word)):
        end += 1
        result = word
    else:
        b += 1
        end += 1
        continue
        pass

print("Longest substring in alphabetical order is: %s" % result)
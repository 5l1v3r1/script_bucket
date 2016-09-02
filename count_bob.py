#!/usr/bin/env python
# -*- coding: utf-8 -*-


# read a string
s = input("Input a string: ")
s_preset = "bobbobsfdbobebobs"


# count bobs
print("+++++++++++++\nUsing built-in count function\n+++++++++++++")
count = s.count("bob")
print("I found %d bobs" % count)

count_1 = s_preset.count("bob")
print("%s bobs in the preset string" % count_1)


# do it manually
print("+++++++++++++\nDoing it manually\n+++++++++++++")
b = 0
end = len("bob")
count_1 = 0
while(end <= len(s_preset)):
    bob = s_preset[b:end]
    print(bob)
    if(bob == "bob"):
        count_1 += 1
    b += 1
    end += 1

print(count_1)
import sys

n = int(input().strip())
n_b = str(bin(n))[2:]
print(n_b)

# all 1?
'''

'''
def is_1(s):
    for i in range(len(s) -1):
        if(s[i] != s[i+1] or s[i] != "1"):
            return False
    return True

if(is_1("11111111111111")):
    print("yes")
else:
    print("No")

# alg
b = 0
e = 2
result = ""
while(e <= len(n_b)):
    seg = n_b[b:e]
    #print(seg)
    if(is_1(seg)):
        e += 1
        result = seg
        print(seg)
        continue
    else:
        b += 1
        e += 1
        continue

print(result)
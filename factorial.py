#!/usr/bin/env python
# -*- coding: utf-8 -*-

def factorial(n):
    fac = n
    while(n > 1):
        tmp = n - 1
        fac *= tmp
        n -= 1
    return fac

n = int(input())
print(factorial(n))
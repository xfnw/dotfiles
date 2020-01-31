#!/usr/bin/env python3

import math, sys

si = input('size append d r c a> ')
print()
st = si[-1:]

try:
    si = float(si[:-1])
except:
    print('invalid input, please use the format <value><type letter>')
    sys.exit()

def fromD(di):
    r = di/2
    fromR(r)

def fromC(ce):
    r = ce / 6.28
    fromR(r)

def fromA(ar):
    r = math.sqrt(ar/3.14)
    fromR(r)

def fromR(ra):
    print("radius",ra)
    print("diam", ra*2)
    print("cerc", 3.14 * (ra*2))
    print("area", 3.14*(ra*ra))

funcs = {
    'd':fromD,
    'r':fromR,
    'c':fromC,
    'a':fromA
}

if st in funcs:
    funcs[st](si)
else:
    print("invalid value type, the options are:")
    for i in funcs:
        print(i)



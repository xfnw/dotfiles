#!/usr/bin/env python3

import math

si = input('size append d r c a> ')

st = si[-1:]

si = float(si[:-1])

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

funcs[st](si)


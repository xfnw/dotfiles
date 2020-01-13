#!/usr/bin/env python3

import argparse

parser = argparse.ArgumentParser(description='bruteforce some moduluses')

parser.add_argument('-s', dest='s', help="start at this number", type=int, default=0)
parser.add_argument('-m', dest='m', help="the modulus", type=int, default=1)
parser.add_argument('-e', dest='e', help="what it will equal", type=int, default=1)
parser.add_argument('-f', dest='f', help="combinations to find", type=int, default=5)

args = parser.parse_args()

i = args.s
m = args.m
e = args.e
toFind = args.f

found = []

while len(found) < toFind:
    if i % m == e:
        found.append(i)
    i=i+1
print(found)


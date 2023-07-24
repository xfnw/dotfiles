#!/usr/bin/env python3
# adapted from https://codegolf.stackexchange.com/a/17872

import re, sys


def findregex(winners, losers):
    "Find a regex that matches all winners but no losers (sets of strings)."
    # Make a pool of candidate components, then pick from them to cover winners.
    # On each iteration, add the best component to 'cover'; finally disjoin them together.
    pool = candidate_components(winners, losers)
    cover = []
    while winners:
        best = max(pool, key=lambda c: 3 * len(matches(c, winners)) - len(c))
        cover.append(best)
        pool.remove(best)
        winners = winners - matches(best, winners)
    return "|".join(cover)


def candidate_components(winners, losers):
    "Return components, c, that match at least one winner, w, but no loser."
    parts = set(mappend(dotify, mappend(subparts, winners)))
    wholes = {"^" + winner + "$" for winner in winners}
    return wholes | {p for p in parts if not matches(p, losers)}


def mappend(function, *sequences):
    """Map the function over the arguments.  Each result should be a sequence.
    Append all the results together into one big list."""
    results = map(function, *sequences)
    return [item for result in results for item in result]


def subparts(word):
    "Return a set of subparts of word, consecutive characters up to length 4, plus the whole word."
    return set(word[i : i + n] for i in range(len(word)) for n in (1, 2, 3, 4))


def dotify(part):
    "Return all ways to replace a subset of chars in part with '.'."
    if part == "":
        return {""}
    else:
        return {c + rest for rest in dotify(part[1:]) for c in (".", part[0])}


def matches(regex, strings):
    "Return a set of all the strings that are matched by regex."
    return {s for s in strings if re.search(regex, s)}


if __name__ == "__main__":
    with open(sys.argv[2]) as includefile:
        include = set(includefile.read().splitlines())
    with open(sys.argv[1]) as excludefile:
        exclude = set(excludefile.read().splitlines())

    exclude -= include
    print(findregex(include, exclude))

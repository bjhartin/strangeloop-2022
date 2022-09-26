I said in the lecture that CHOOSE only returns one value. The operation is *deterministic*. This means that if S and T are the same sets, then it is *always true that*

  CHOOSE x \in S: F(x) = CHOOSE y \in T: F(y)

*How* this is guaranteed is an implementation detail. The TLA+ model checker, TLC, does it by casting all values to Java types and then choosing the smallest value. For example:

  CHOOSE x \in {1, 2, 3}: TRUE

Always returns 1. For things that aren't comparable (like CHOOSING over sets), they're instead compared by their lexographic string representation.

---

CHOOSE is also sometimes called "Hilbert's Epsilon operator", but it's not nearly as ubiquitous as \A and \E.


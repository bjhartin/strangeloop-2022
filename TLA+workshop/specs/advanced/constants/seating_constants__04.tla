
---- MODULE seating_constants__04 ----
EXTENDS Integers
CONSTANTS NumChairs, Person, NoChair
VARIABLES sitting_in
vars == <<sitting_in>>

Chairs == 1..NumChairs

Occupied(c) ==
  \E p \in Person:
    sitting_in[p] = c

SetChair(p, c) ==
  sitting_in' = [sitting_in EXCEPT ![p] = c]

Sit(p, c) ==
  /\ sitting_in[p] = 0
  /\ ~Occupied(c)
  /\ SetChair(p, c)

Stand(p) ==
  /\ sitting_in[p] # 0  
  /\ SetChair(p, 0)

Init ==
  /\ sitting_in = [p \in Person |-> 0] 

Next ==
  \E p \in Person, c \in Chairs:
    \/ Sit(p, c)
    \/ Stand(p)

Spec == Init /\ [][Next]_vars

TypeInv ==
  \A p \in Person:
    sitting_in[p] \in Chairs \union {0}

ChairInv ==
  \A p1, p2 \in Person:
    /\ sitting_in[p1] # 0
    /\ p1 # p2
    => sitting_in[p1] # sitting_in[p2]
====


---- MODULE seating_constants__05 ----
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
  /\ sitting_in[p] = NoChair
  /\ ~Occupied(c)
  /\ SetChair(p, c)

Stand(p) ==
  /\ sitting_in[p] # NoChair  
  /\ SetChair(p, NoChair)

Init ==
  /\ sitting_in = [p \in Person |-> NoChair] 

Next ==
  \E p \in Person, c \in Chairs:
    \/ Sit(p, c)
    \/ Stand(p)

Spec == Init /\ [][Next]_vars

TypeInv ==
  \A p \in Person:
    sitting_in[p] \in Chairs \union {NoChair}

ChairInv ==
  \A p1, p2 \in Person:
    /\ sitting_in[p1] # NoChair
    /\ p1 # p2
    => sitting_in[p1] # sitting_in[p2]
====

---- MODULE seating__07 ----
EXTENDS Integers
VARIABLES sitting, chairs
vars == <<sitting, chairs>>
Person == {"Alice", "Bob"}

Init ==
  sitting = {} 
  /\ chairs = 1
  
Sit(p) ==
  /\ p \notin sitting
  /\ chairs > 0
  /\ sitting' = sitting \union {p}
  /\ chairs' = chairs - 1

Stand(p) ==
  /\ p \in sitting
  /\ sitting' = sitting \ {p}
  /\ chairs' = chairs + 1

Next ==
  \E p \in Person:
    \/ Sit(p)
    \/ Stand(p)

Spec == Init /\ [][Next]_vars 

ChairInv == chairs >= 0
====

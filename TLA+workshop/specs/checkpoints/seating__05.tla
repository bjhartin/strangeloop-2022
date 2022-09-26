---- MODULE seating__05 ----
EXTENDS Integers
VARIABLES sitting
vars == <<sitting>>
Person == {"Alice", "Bob"}

Init ==
  sitting = {}
  
Sit(p) ==
  /\ p \notin sitting
  /\ sitting' = sitting \union {p}

Stand(p) ==
  /\ p \in sitting
  /\ sitting' = sitting \ {p}

Next ==
  \E p \in Person:
    \/ Sit(p)
    \/ Stand(p)

Spec == Init /\ [][Next]_vars
====

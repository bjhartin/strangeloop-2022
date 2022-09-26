---- MODULE seating__04 ----
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
  \/ Sit("Bob")
  \/ Stand("Bob")

Spec == Init /\ [][Next]_vars
====

---- MODULE seating__03 ----
EXTENDS Integers
VARIABLES sitting
vars == <<sitting>>
Person == {"Alice", "Bob"}

Init ==
  sitting = {}
  
Sit ==
  /\ "Bob" \notin sitting
  /\ sitting' = sitting \union {"Bob"}

Stand ==
  /\ "Bob" \in sitting
  /\ sitting' = sitting \ {"Bob"}

Next ==
  \/ Sit
  \/ Stand

Spec == Init /\ [][Next]_vars
====

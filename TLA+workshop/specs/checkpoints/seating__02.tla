---- MODULE seating__02 ----
EXTENDS Integers
VARIABLES sitting
vars == <<sitting>>

Init ==
  sitting = FALSE
  
Sit ==
  /\ ~sitting
  /\ sitting' = TRUE

Stand ==
  /\ sitting
  /\ sitting' = FALSE

Next ==
  \/ Sit
  \/ Stand

Spec == Init /\ [][Next]_vars
====

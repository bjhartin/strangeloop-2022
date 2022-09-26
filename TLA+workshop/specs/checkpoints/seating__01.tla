---- MODULE seating__01 ----
EXTENDS Integers
VARIABLES sitting
vars == <<sitting>>

Init ==
  sitting = FALSE
  
Sit ==
  sitting' = TRUE

Stand ==
  sitting' = FALSE

Next ==
  \/ Sit
  \/ Stand

Spec == Init /\ [][Next]_vars
====

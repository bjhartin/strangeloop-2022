---- MODULE seating__08 ----
EXTENDS Integers
VARIABLES sitting_in
vars == <<sitting_in>>
Person == {"Alice", "Bob"}
Chairs == 1..1 \* 0 = no chair


Sit(p, c) ==
  /\ sitting_in[p] = 0
  /\ sitting_in' = [sitting_in EXCEPT ![p] = c]

Stand(p) ==
  /\ sitting_in[p] # 0  
  /\ sitting_in' = [sitting_in EXCEPT ![p] = 0]

Init ==
  /\ sitting_in = [p \in Person |-> 0] 

Next ==
  \E p \in Person, c \in Chairs:
    \/ Sit(p, c)
    \/ Stand(p)

Spec == Init /\ [][Next]_vars
====

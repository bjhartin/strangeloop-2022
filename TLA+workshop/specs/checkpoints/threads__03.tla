---- MODULE threads__03 ----
EXTENDS Integers
VARIABLES has_token, tokens, times_ran
vars == <<has_token, tokens, times_ran>>
Threads == 1..2

GetToken(t) ==
  /\ t \notin has_token
  /\ tokens > 0
  /\ times_ran[t] < 3
  /\ has_token' = has_token \union {t}
  /\ tokens' = tokens - 1
  /\ UNCHANGED times_ran

ReleaseToken(t) ==
  /\ t \in has_token
  /\ has_token' = has_token \ {t}
  /\ tokens' = tokens + 1
  /\ times_ran' = [times_ran EXCEPT ![t] = times_ran[t] + 1]

Init ==
  /\ has_token = {} 
  /\ tokens = 1
  /\ times_ran = [t \in Threads |-> 0]

Next ==
  \E t \in Threads:
    \/ GetToken(t)
    \/ ReleaseToken(t)

Spec == Init /\ [][Next]_vars 

TokenInv == tokens >= 0
====

---- MODULE threads__01 ----
EXTENDS Integers
VARIABLES has_token, tokens
vars == <<has_token, tokens>>
Threads == 1..2

GetToken(t) ==
  /\ t \notin has_token
  /\ tokens > 0
  /\ has_token' = has_token \union {t}
  /\ tokens' = tokens - 1

ReleaseToken(t) ==
  /\ t \in has_token
  /\ has_token' = has_token \ {t}
  /\ tokens' = tokens + 1

Init ==
  /\ has_token = {} 
  /\ tokens = 1

Next ==
  \E t \in Threads:
    \/ GetToken(t)
    \/ ReleaseToken(t)

Spec == Init /\ [][Next]_vars 

TokenInv == tokens >= 0
====

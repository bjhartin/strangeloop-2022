---- MODULE backups_fix ----
EXTENDS Integers

CONSTANTS MaxVersion, Computers, StartingComp
VARIABLES 
  global_version, documents, upload, current

vars == <<global_version, documents, upload, current>>

Versions == 0..MaxVersion

Init ==
  /\ global_version = 1
  /\ documents = [c \in Computers |-> 0]
  /\ upload = [c \in Computers |-> 0]
  /\ current \in Computers \* symmetry breaker TODO write both versions

Push(c) ==
  /\ upload' = [upload EXCEPT ![c] = documents[c]]
  /\ UNCHANGED <<documents, global_version, current>>

PullFrom(target) ==
  /\ upload[target] > documents[current]
  /\ documents' = [documents EXCEPT ![current] = upload[target]]
  /\ UNCHANGED <<upload, global_version, current>>

SwitchComputers(c) ==
  /\ c # current
  /\ current' = c
  /\ UNCHANGED <<upload, global_version, documents>>

Write(doc) ==
  /\ documents[doc] < MaxVersion
  /\ documents' = [documents EXCEPT ![doc] = global_version]
  /\ global_version' = global_version + 1
  /\ UNCHANGED <<current, upload>>

Done ==
  /\ upload[current] = global_version
  /\ UNCHANGED vars

Next ==
  \/ \E c \in Computers:
     \/ PullFrom(c)
     \/ Push(c)
     \/ Write(c)
     \/ SwitchComputers(c)
  \/ Done

Spec == Init /\ [][Next]_vars

NoOverwrites ==
  [][
    LET WentBackwards(x) == x' < x
    IN
      /\ \A c \in Computers:
        /\ ~WentBackwards(documents[c])
        /\ ~WentBackwards(upload[c])
  ]_vars
====

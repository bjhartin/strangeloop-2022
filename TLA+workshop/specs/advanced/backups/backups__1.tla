---- MODULE backups__1 ----
EXTENDS TLC, Integers
CONSTANTS MaxVersion, Computers
VARIABLES 
  global_version, documents, upload \* on computer

vars == <<global_version, documents, upload>>

Versions == 0..MaxVersion

Init ==
  /\ global_version = 1
  /\ documents = [c \in Computers |-> 0]
  /\ upload = 0

Pull(doc) ==
  /\ documents' = [documents EXCEPT ![doc] = upload]
  /\ UNCHANGED <<upload, global_version>>

Push(doc) ==
  /\ upload' = documents[doc]
  /\ UNCHANGED <<documents, global_version>>

Write(doc) ==
  /\ documents[doc] < MaxVersion
  /\ documents' = [documents EXCEPT ![doc] = global_version]
  /\ global_version' = global_version + 1
  /\ UNCHANGED <<upload>>

Done ==
  /\ upload = global_version
  /\ UNCHANGED vars

Next ==
  \/ \E c \in Computers:
     \/ Pull(c)
     \/ Push(c)
     \/ Write(c)
  \/ Done

Spec == Init /\ [][Next]_vars

NoOverwrites ==
  [][
    LET WentBackwards(x) == x' < x
    IN
      /\ ~WentBackwards(upload)
      /\ \A c \in Computers: \* Try commenting this out!
        ~WentBackwards(documents[c])
  ]_vars

====
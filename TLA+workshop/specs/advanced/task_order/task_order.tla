---- MODULE task_order ----
EXTENDS TLC, Integers, FiniteSets
CONSTANT Workers, MaxNum, QueueLen
VARIABLES x, i, aux_result, queue
vars == <<x, i, aux_result, queue>>
set ++ y == set \union {y}

Tasks == {"ADD", "MUL"} \X (1..MaxNum)  \* WAIT
QueueType == [1..QueueLen -> Tasks]

TypeInv ==
    /\ x \in Nat
    /\ i \in [Workers -> 1..(QueueLen + 1)]
    /\ aux_result \subseteq Int
    /\ queue \in [Workers -> QueueType]

Init ==
    /\ x = 0
    /\ i = [w \in Workers |-> 1]
    /\ aux_result = {}
    /\ queue \in [Workers -> QueueType]

RunTask(task) ==
    LET cmd == task[1]
        val == task[2]
    IN 
        CASE cmd = "ADD" -> x' = x + val
          [] cmd = "MUL" -> x' = x * val
          [] cmd = "SUB" -> x' = x - val


Worker(w) ==
    /\ i[w] <= QueueLen
    /\ RunTask(queue[w][i[w]])
    /\ i' = [i EXCEPT ![w] = @ + 1]
    /\ UNCHANGED aux_result

RecordComplete ==
    /\ \A w \in Workers:
      ~(ENABLED Worker(w)) \* might not work
      \* queue[i] > QueueLen
    /\ aux_result' = aux_result ++ x
    /\ x' = 0
    /\ i' = [w \in Workers |-> 1] \* was 0!

Next ==
    /\ UNCHANGED queue
    /\ \/ \E w \in Workers:
            Worker(w)
       \/ RecordComplete

Spec == Init /\ [][Next]_vars

Deterministic ==
    Cardinality(aux_result) <= 1

====
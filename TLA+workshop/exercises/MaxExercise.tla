---- MODULE MaxExercise ----
EXTENDS Exercise

\* PROBLEM: Write Max(set) which returns the maximum element of a set.
Max(set) == CHOOSE x \in set:
  \A y \in set: 
    (y <= x)   \* Replace this with your solution. 


\* To test this, run the "TLA+: Evaluate Expression" with "Test" (ctrl+shift+P TLA+ Test)






\* Dark magic, don't worry about this please
Test = TestMax(Max)
\* \End dark magic
====

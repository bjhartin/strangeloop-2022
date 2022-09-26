---- MODULE BasicLogic ----
EXTENDS Exercise


\* PROBLEM 1: Write Increment(x), which adds 1 to x.
\* This is not a trick, this is just to get familiar with exercises

Increment(x) == x + 1\* Replace this with your solution

\* PROBLEM 2: Convert (x < 10) && (x > 2) && !(x % 5 > 3) to TLA+.
\* Remember, you have /\ \/ ~.

Prop(x) == (x < 10) /\ (x > 2) /\ ~(x % 5 > 3) 


\* To test this, run the "TLA+: Evaluate Expression" with "Test" (ctrl+shift+P TLA+ Test)
\* Once you get it working, try breaking it!



\* Dark magic, don't worry about this please
Test == TestProplogic(Increment, Prop)
\* \End dark magic
====

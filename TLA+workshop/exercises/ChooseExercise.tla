---- MODULE ChooseExercise ----
EXTENDS Exercise

\* PROBLEM: Write Choose(a, b, c) which returns the solution to ax^2+bx+c = 0. x will ALWAYS be in `0..100` (TLA+ for {0, 1, 2, ... 100})
Choose(a, b, c) == CHOOSE x \in 0..100: (a*x^2 + b*x + c = 0)  \* Replace this with your solution. 

(* NOTE:
If you get this one wrong, you might get an error like this:

Error evaluating expression:
Evaluating assumption line 5, col 8 to line 5, col 52 of module t1663087647927 failed.
Attempted to compute the value of an expression of form
CHOOSE x \in S: P, but no element of S satisfied P.
line 5, col 20 to line 5, col 58 of module ChooseExercise

*)

\* Also dark magic, don't worry about this please
Test == TestChoose(Choose)
\* \End dark magic

====

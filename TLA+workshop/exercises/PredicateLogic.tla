---- MODULE PredicateLogic ----
EXTENDS TLC, Exercise

\* Predicate expressions are of the form:
\* \A x \in set: expr
\* \E x \in set: expr

\* PROBLEM 1: Write LessThan5(set), saying all elements of the set are less than 5.

LessThan5(set) == \A x \in set: (x < 5) \* Replace this with your solution. 

\* Problem 2: Write OneApart(set), 
\* which checks if there are two elements x, y in a set where x = y + 1
HasTwoApart(set) == \E x,y \in set: (x = y + 1)

\* EXTRA CREDIT: You can get the last digit of a number with num % 10.
\* Write SameLastDigit(set), which checks that all numbers in set
\* have the same last digit.

SameLastDigit(set) == \A x,y \in set: (x % 10 = y % 10)

\* Dark magic, don't worry about this please
Test == TestPredicateLogic(LessThan5, HasTwoApart, SameLastDigit)
\* \End dark magic

====
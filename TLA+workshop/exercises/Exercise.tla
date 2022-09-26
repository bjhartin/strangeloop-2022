PLEASE do not look at how this module works until the end of the workshop! 
I made this to hack in some form of multiple-choice exercises in TLA+. 


---- MODULE Exercise ----
EXTENDS Integers, TLC, Sequences, FiniteSets

WrongAnswer(case, sol(_), ans(_)) ==
    "Test Error: for " 
    \o ToString(case) 
    \o " the answer should be "
    \o ToString(sol(case))
    \o ", but you got " 
    \o ToString(ans(case)) \o "."

TestAll(test_set, sol(_), ans(_)) ==
    IF \E t \in test_set: sol(t) # ans(t)
    THEN
      LET failing_case == CHOOSE t \in test_set: sol(t) # ans(t) IN
        WrongAnswer(failing_case, sol, ans)
    ELSE
      "Correct!"

NSub(s) == (SUBSET s) \ {{}}

Format(name, result) ==
    name \o "  ---->  " \o result \o "     ::::      "

----------------------------------------


TestProplogic(ans1(_), ans2(_)) ==
    LET
        sol1(x) == x + 1
        sol2(x) == (x < 10) /\ (x > 2) /\ ~(x % 5 > 3)
        tests == 1..20
        Do(x, f(_), g(_)) == Format(x, TestAll(tests, f, g))
    IN 
      Do("Increment", sol1, ans1) \o
      Do("Prop", sol2, ans2)

TestPredicateLogic(ans1(_), ans2(_), ans3(_)) ==
    LET 
        sol1(s) == \A x \in s: x < 5
        sol2(s) == \E x, y \in s: x = y + 1
        sol3(s) == \E digit \in 0..9: \A x \in s: x % 10 = digit
        tests == NSub(2..7)
        ectests == {{RandomElement(30..60): x \in 1..3}: y \in 1..2000} \* dont' like this is random, may change
        Do(x, f(_), g(_)) == Format(x, TestAll(tests, f, g))
    IN Do("LessThan5  ", sol1, ans1) \o
       Do("HasTwoApart", sol2, ans2) \o
       Format("Extra Credit", TestAll(ectests, sol3, ans3))

TestMax(Func(_)) ==
  LET  
    MaxSol(set) == CHOOSE x \in set: \A y \in set: y <= x
  IN
    TestAll(NSub(1..5), MaxSol, Func)

TestChoose(ans(_, _, _)) ==
  LET sol(s) == CHOOSE x \in 0..100: s[1]*x^2 + s[2]*x + s[3] = 0
    ans_a1(s) == ans(s[1], s[2], s[3])
    tests == {<<1, -6, 9>>, <<1, -2, -15>>, <<1, -128, 2727>>, <<13, -598, 0>>}
  IN
    TestAll(tests, sol, ans_a1)
    


====

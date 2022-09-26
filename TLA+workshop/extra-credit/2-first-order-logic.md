Predicate logic is called "First-order logic" because predicates aren't first class: you can't pass a predicate into another predicate. YOu also can't quantify over predicates. This means you can't say things like

    IsSymmetric(pred) == \A x, y \in Nat: pred(x, y) = pred(y, x)

Logics that can do this are called *higher order logics*. Logicians avoid them like the plague because they have truly terrifying properties, like "non-absoluteness". I don't completely understand how that works exactly but when I asked my logician professor friend he screamed and ended the zoom call. I miss him.

Some restrictions to HOL, though, can be extremely useful. To my understanding, there's a mapping between certain fragments of HOL and certain type theories. But I am not a type theorist or a programming language theorist so I couldn't say for certain what those actually *are*.

(TLA+ *does* have higher-order operators, though only in accepting operators as arguments (not as outputing operators as values). We won't be covering them in this class.)

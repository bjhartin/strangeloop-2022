# Monad, I Love You, Now Get Out of my Type System


## Summary

This speaker introduced a new library, 'Optimus Prime', which was developed at Morgan Stanley to allow Scala programmers to stop using monads like Future and cats' IO for concurrency.  Instead, it takes the following position:

A set S of referentially transparent functions {f1, f2, ... fn}, which have no dependencies on each other, may be executed in any order or, if resources allow, concurrently.

## Resources

- Conference blurb: https://thestrangeloop.com/2022/monad-i-love-you-now-get-out-of-my-type-system.html
- Speaker: Gjeta Gjyshinca
- Strangeloop video: TBD
- [Talk 1 from ScalaDays 2018](https://www.youtube.com/watch?v=BW8S92jP5sE) - I think this is a better talk, actually - same presenter
- [Talk 2 from ScalaDays 2018](https://www.youtube.com/watch?v=Svgh3mkHtWA) - Similar talk from a different ScalaDays


## Details

Consider the following functions, if written on a blackboard:

```
f(x) = x^2
g(x) = x-3
h(x) = 2*x
i(x,y,z) = x + y + z

a = f(1)
b = g(4)
c = h(5)
d = i(a,b,c)
```

Suppose we have two students working on this.  In what order must they solve for `a,b,c` and `d`?

The answer is: `a,b,c` can be solved in _any_ order, but `d` must be done after them.  This is the same sort of calculation done when resolving dependencies, e.g. in what order to compile files or execute build tasks.

The core idea of this talk is: why should functional computer programs be any different?  Thinking of a function body as a sequence of steps is a hold-over from Turing machines - which were used as a model for electronic computer architectures and hence imperative languages.  Functional programming is based on lambda calculus - an equivalent theory [1] which models computation without notions of time and state - similar to the algebraic equations above.  For pure functions, why execute them using an unnecessarily restrictive model, requiring us to use monads like Future (or other techniques) to represent what is fundamentally just independence?  Asynchrony becomes the norm (for ref. transp. functions).

This is achieved by marking referentially transparent functions with a `@node` annotation (I never learned why it is called 'node').  We might model a situation similar to the above as follows:

```
@node def f(x: Int): Int = x^2
@node def g(x: Int): Int = x-3
@node def h(x: Int): Int = 2*x
@node def i(x: Int, y: Int, z: Int) = x + y + z

def i(x: Int, y: Int, z: Int): Int = {
  // Var used intentionally for example
  var x = 0

  val a = f(1)
  val b = g(4)
  val c = h(5)

  // Extra code which is not ref. transp. because it mutates shared state - order matters.
  // This is a 'side effect' of the expressions.
  x = x + 1
  x = x * 2

  val d = i(a,b,c)
  d
}
```

This library includes a solver which would determine the order in which to execute the expressions in this function.  Presumably, this would happen as follows:

- var x is initialized to zero
- vals a,b,c are assigned by executing f,g,h in any order or simultaneously if we have enough threads in the pool
- x is reassigned twice.  Order obviously matters here (try it).
- val d is assigned last since it depends on a,b and c.

Marking a function as a node also indicates that it is memoizable.  Pure functions don't need to be re-executed for the same arguments - the answer will always be the same.  This library includes cacheing so that a call to `f(1)` is never executed twice.

The net effect of this, as claimed, is to allow developers to focus more on the business logic.  Monads are still present for things like failure, optionality, etc. - just not for time.

Like SQL, this involves a scheduler which is making decisions about an execution plan so performance tuning will be different than traditional code.

### Background and Resources

1- When computation was formally described, independently, by Turing, Church and Gödel in the early 20th century [2], Turing's model was used as the basis for computers as we know them.  His model involves thinking in sequences of steps and state changes.  We therefore learned to think about computation in terms of _time_ and _change_.  The other models are more algebraic, replacing time with dependency and trading total orders for partial orders.

2 - [Propositions as Types, Philip Wadler, Strangeloop](https://www.youtube.com/watch?v=IOiZatlZtGU)


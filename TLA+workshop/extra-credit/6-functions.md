Mathematically speaking, functions are mapping between sets of values. Conventionally, mathematicians write `f: A -> B` to mean "f is a function which takes any value in the set A oand spits out values that are all in the set B". Note that f doesn't have to be *surjective*, IE cover ALL of B. But it must cover all of A. We say that A is the **domain**, B is the **codomain**, and the actual subset of B that f covers is the **range**.¹

You can get the domain of a TLA+ function with `DOMAIN F`. You can also define the set of *all* functions with a given domain and codomain with `[A -> B]`.

¹ Notice that a function can have multiple codomains: `f(x) = 0` can equally well be described as having codomain {0}, {0, 1, ...}, Int, Reals... Poke at this hard enough and you start getting formal definitions of things like covariance, contravariance, and Liskov Substitution.

## Function-Array equivalence

Take the array `l = [hello, world, !]`, and assume for some completely inane reason that we start arrays at 1. Then we can get the values like this:

   l[1] = hello
   l[2] = world
   l[3] = !

If you sorta squint, doesn't this look kinda like a function? Couldn't you say that `l: 1..3 -> String`? Similarly, could you say that `sq = [1, 4, 9, 16, 25]` could be described as `sq: 1..5 -> Int`?

You can, and in fact mathematicians *do*: a sequence is just a function with domain 1..n! TLA+ does this under the hood: the sequence `<<x, y>>` is a function with domain `1..2`. 

## Operators and Russell's Paradox

Now functions in programming languages are very different from mathematical functions, much closer to what TLA+ calls "operators". Statically-typed FP languages, like Haskell and OCaml, have functions that are more "accurate". But they are not *completely* accurate, because there are some things that *cannot* be functions. For example, `id`! 

Let's say `id: A->B` and `id(x) = x`. Then the domain of `id` is *everything*. Every number, every set of numbers, every set of functions from numbers to lists of sets of numbers, etc. It's the set of all sets, which *includes* the set of all sets. This, in the parlance of mathematics, is Very Bad.

So id cannot be a function. TLA+ and most logics get around this by classifying it as something else, like an operator. FP languages can "cheat" with parametric polymorphism. Instead of `id` being a function, it's a family of possible functions, each specialized to one type. So if you call `id 5`, you're "actually" calling the function with type signature `Int -> Int`.

This is, at least, one way to make it *consistent* with the mathematical definition of function. Languages in the wild can do whatever they want. I think ghc has a compiler option to "monomorphize" your functions, and otherwise uses a lookup table at runtime.

(This all isn't a problem for FP languages, I just think it's a really interesting topic!)

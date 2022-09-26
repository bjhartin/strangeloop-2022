Temporal logic is a kind of **modal logic**. Modal logics are actually a class of different *kinds* of logic, but they all share a similar goal, to "qualify" truths as "necessarily true" (□) and "possibly true" (◇), strong and weak. What "necessarily" and "possibly" mean depends on the kind of logic. For temporal logic, "necessarily" is "true at all times" and "possibly" is "true at some times". Some other flavors of modal logic:

 * Alethic Logic: □p means that p is true in all possible worlds, ◇p is true in at least some possible alternate realities ("is bigfoot real?")
 * Epistemic Logic: □p means that p is known to be true, ◇p means that p is not known to be false.
 * Deontologic Logic: □p means that p is a moral obligation, ◇p means that p is not morally forbidden.

Most modal logics are primarily interesting to philosophers and linguists, and temporal logic is the only mode I know of with widespread use in computer science. But there are some others with niche applications! In [this paper](https://2021.splashcon.org/details/splash-2021-recent-sigplan/15/Programming-and-Reasoning-with-Partial-Observability), they used modal logic to model uncertainty in sensor readings. IE `□(height>10)` meant "in all of our sensor readings, the height is above ten", while `◇(height > 10)` means "at least one sensor read that the height is above 10."

(Modal logic is also useful for informal reasoning. If I tell you "this code is bug-free" and provide a test suite as evidence, does that necessarily* mean there's no bugs? Or just that it's *possible* there's no bugs?)
